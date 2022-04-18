//
//  Collection+ext.swift
//
//  Created by Shimin lyu on 24/1/2021.
//

import Foundation

extension Collection {
    public var isNotEmpty: Bool {
        !isEmpty
    }
}
extension Sequence {
    public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}
