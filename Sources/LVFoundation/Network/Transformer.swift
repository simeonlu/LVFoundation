//
//  Transformer.swift
//
//  Created by Shimin lyu on 20/3/2022.
//

import Foundation

/// Protocol that defines how to transform raw data to data model.
public protocol ModelTransforming {
    associatedtype Model: Decodable
    typealias Transforming = (Data, URLResponse) throws -> Model
    var transform: Transforming { get }
}

public struct JsonModelTransformer<Model: Decodable>: ModelTransforming {
    public init() {}
    public var transform: Transforming = { (data, _) in
        do {
            return try JSONDecoder().decode(Model.self, from: data)
        } catch(let error) {
            throw NetworkError.decode(description: error.localizedDescription)
        }
    }
}
