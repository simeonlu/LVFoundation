//
//  Transformer.swift
//
//  Created by Shimin lyu on 20/3/2022.
//

import Foundation

/// Protocol define how to transform raw data to data model.
public protocol ModelTransformable {
    associatedtype Model: Decodable
    typealias Transform = (Data, URLResponse) throws -> Model
    var transform: Transform { get }
}
