//
//  NetworkError.swift
//
//  Created by Shimin lyu on 20/3/2022.
//

import Foundation

public enum NetworkError: LocalizedError {
    case timeout
    case forbidden
    case invalidPayload
    case decode
    case unknown
}

public extension NetworkError {
    
    /// Map http status code to `NetworkError`
    /// - Parameter statusCode: code number to map
    /// - Returns:  instance of `NetworkError`
    static func map(_ statusCode: Int) -> Self {
        switch statusCode {
        case 403:
            return .forbidden
        case NSURLErrorTimedOut:
            return .timeout
        default:
            return .unknown
        }
    }
    
    /// Map URLError  to `NetworkError`
    /// - Parameter urlError: error to map
    /// - Returns: instance of `NetworkError`
    static func map(_ urlError: URLError) -> Self {
        guard  urlError.errorCode == NSURLErrorTimedOut else {
            return .unknown
        }
        return .timeout
    }
}
