//
//  DataLoader.swift
//
//  Created by Shimin lyu on 20/3/2022.
//

import Foundation
import Combine

public protocol Loadable {
    associatedtype Model: Decodable
    func fetchModel<T: ResponseTransformable>(
        for endpoint: Endpoint,
        transformer: T) -> AnyPublisher<Model, Error> where T.Model == Model
}

public struct DataLoader<Model: Decodable>: Loadable {
    
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
    public func fetchModel<T: ResponseTransformable>(
        for endpoint: Endpoint,
        transformer: T) -> AnyPublisher<Model, Error> where T.Model == Model {
        let request = endpoint.makeRequest()
        return
            session
            .dataTaskPublisher(for: request)
            .mapError(NetworkError.map)
            .filterSuccessfulStatusCodes()
            .tryMap(transformer.transform)
            .print()
            .eraseToAnyPublisher()
    }
    
    public func fetchModel<T: ResponseTransformable>(
        for endpoint: Endpoint,
        transformer: T
    ) -> Future<Model, Error> where T.Model == Model {
        let request = endpoint.makeRequest()
        return Future<Model, Error> { promise in
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                }
                guard let resp = response, let data = data else {
                    promise(.failure(NetworkError.invalidPayload))
                    return
                }
                do {
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
            guard let response = result.response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            guard (200...299).contains(response.statusCode) else {
                throw NetworkError.map(response.statusCode)
            }
            return result
        }
        
    }
    
}
