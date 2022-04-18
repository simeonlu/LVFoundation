//
//  Endpoint.swift
//
//  Created by Shimin lyu on 22/3/2022.
//

import Foundation

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
    case patch  = "PATCH"
}

public enum HTTPScheme: String {
    case http
    case https
}

public protocol Endpoint {
    var scheme: HTTPScheme { get }
    
    var host: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
    var method: HTTPMethod { get }
}

public extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        components.queryItems = parameters.isEmpty ? nil : parameters
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    func makeRequest(requestTimeoutInterval: TimeInterval = 10) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: requestTimeoutInterval)
        request.httpMethod = method.rawValue
        return request
    }
}

public struct APIEndpoint: Endpoint {
   
    public let host: String
    
    public let path: String
    
    public var scheme: HTTPScheme = .https
    
    public var parameters: [URLQueryItem] = []
    
    public var method: HTTPMethod = .get
}

