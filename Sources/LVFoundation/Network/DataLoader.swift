//
//  DataLoader.swift
//
//  Created by Shimin lyu on 20/3/2022.
//

import Foundation
import Combine

public protocol Loadable {
    func fetchResource<T: ResponseTransformable>(
        for endpoint: Endpoint,
        transformer: T) -> AnyPublisher<T.Model, Error>
    
    @available(iOS 15.0, macCatalyst 15.0, *)
    func fetchResource<T: ResponseTransformable>(
        for endpoint: Endpoint,
        transformer: T) async throws -> T.Model
}

public struct DataLoader: Loadable {
    
    public init() {}
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }()
    
    /// Fetch model data
    /// - Parameters:
    ///   - endpoint: URL Endpoint
    ///   - transformer: transformer used to parse the data
    /// - Returns: `Model` Publisher
    public func fetchResource<T: ResponseTransformable>(
        for endpoint: Endpoint,
        transformer: T) -> AnyPublisher<T.Model, Error> {
            let request = endpoint.makeRequest()
            return session
                .dataTaskPublisher(for: request)
                .mapError(NetworkError.map)
                .filterSuccessfulStatusCodes()
                .tryMap(transformer.transform)
                .print()
                .eraseToAnyPublisher()
        }
    
    @available(iOS 15.0, macCatalyst 15.0, *)
    public func fetchResource<T: ResponseTransformable>(
        for endpoint: Endpoint,
        transformer: T) async throws -> T.Model {
            let request = endpoint.makeRequest()
            
            let result: (data: Data, response: URLResponse) = try await session.data(for: request)
            let resp = try result.response.filterSuccessfulHttpStatusCodes()
            return try transformer.transform(result.data, resp)
        }
    
    public func fetchResource<T: ResponseTransformable>(
        for endpoint: Endpoint,
        transformer: T
    ) -> Future<T.Model, Error> {
        let request = endpoint.makeRequest()
        return Future<T.Model, Error> { promise in
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                }
               
                guard let resp = response, let data = data else {
                    promise(.failure(NetworkError.invalidPayload))
                    return
                }
                
                do {
                    _ = try resp.filterSuccessfulHttpStatusCodes()
                    let result = try transformer.transform(data, resp)
                    promise(.success(result))
                } catch (let error) {
                    promise(.failure(error))
                }
            }
            
            dataTask.resume()
        }
    }
    
    public func fetchData(for endpoint: Endpoint) -> Future<(Data, URLResponse), Error> {
        let request = endpoint.makeRequest()
        return Future<(Data, URLResponse), Error> { promise in
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else if let data = data, let response = response {
                    promise(.success((data, response)))
                } else {
                    promise(.failure(NetworkError.invalidPayload))
                }
            }
            dataTask.resume()
        }
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    
    /// Filter out successful response, e.g. http status code is in between 200 to 299.
    /// - Returns: A new publisher, its `Output` is `DataTaskPublisher.Output`
    public func filterSuccessfulStatusCodes() -> Publishers.TryMap<Self, Output> {
        tryMap { result in
            try _ = result.response.filterSuccessfulHttpStatusCodes()
            return result
        }
    }
}

extension URLResponse {
    
    @discardableResult
    func filterSuccessfulHttpStatusCodes() throws -> HTTPURLResponse {
        guard let response = self as? HTTPURLResponse else {
            throw NetworkError.httpError
        }
        guard (200...299).contains(response.statusCode) else {
            throw NetworkError.map(response.statusCode)
        }
        return response
    }
}
