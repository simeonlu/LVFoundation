//
//  Transformer.swift
//
//  Created by Shimin lyu on 20/3/2022.
//

import Foundation

/// Protocol that defines how to transform raw data to data model.
public protocol ResponseTransforming {
    associatedtype Model: Decodable
    typealias Transforming = (Data, URLResponse) throws -> Model
    var transform: Transforming { get }
}

public struct JsonModelTransformer<Model: Decodable>: ResponseTransforming {
    private let dateStrategy: JSONDecoder.DateDecodingStrategy
    public init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) {
        self.dateStrategy = dateDecodingStrategy
    }
    public var transform: Transforming {
        { (data, _) in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = self.dateStrategy
                return try decoder.decode(Model.self, from: data)
            } catch(let error) {
                throw NetworkError.decode(description: error.localizedDescription)
            }
        }
    }
}
