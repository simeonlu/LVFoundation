//
//  Sequence+Ext.swift
//
//  Created by Shimin lyu on 21/3/2020.
//

import Foundation

// find the 'M' smallest
extension Sequence {
    public func smallest(_ m: Int, by isInAsecOrder: (Element, Element) -> Bool) -> [Element] {
      
        var result = prefix(m).sorted(by: isInAsecOrder)
        for item in dropFirst(m) {
            if let last = result.last, isInAsecOrder(last, item) { continue }
            if let insertionIndex = result.firstIndex(where: { isInAsecOrder(item, $0) }) {
                result.insert(item, at: insertionIndex)
                result.removeLast()
            }
        }
        return result
    }
}

extension Sequence where Element: Comparable {
    public func min(_ m: Int) -> [Element] {
        smallest(m, by: <)
    }
    public func max(_ m: Int) -> [Element] {
        smallest(m, by: >)
    }
}

// MARK: - Array extension
extension Array where Element: Comparable {
    public func binarySearch(key: Element) -> Int? {
        var lower = startIndex
        var upper = endIndex
        
        while upper >= lower {
            let mid = lower + (upper - lower) / 2
            if self[mid] > key {
                upper = mid - 1
            } else if self[mid] < key {
                lower = mid + 1
            } else {
                return mid
            }
        }
        return nil
    }
}

extension Array where Element: Equatable {

    /// Remove one item from an Array
    ///
    /// - Parameter item: item to be removed
    public mutating func removeItem(_ item: Element) {
        if let index = self.firstIndex(of: item) {
            self.remove(at: index)
        }
    }
}

// MARK: - Dictionary
extension Dictionary {

    /// concat two dictionary into one dictionary
    ///
    /// - Parameter dictionary: dictionary to be concat
    public mutating func concat(_ dictionary: Dictionary) {
        dictionary.forEach { self.updateValue($1, forKey: $0) }
    }

    /// Apply Transform on each items in dictionary
    ///
    /// - Parameter transform: transform closure
    /// - Returns: new dictionary with item transformed
    /// - Throws: Throw error if error occurred.
    public func map<T: Hashable, U>(transform: (Key, Value) throws -> (T, U)) rethrows -> [T: U] {
        var result: [T: U] = [:]
        for (key, value) in self {
            let (transformedKey, transformedValue) = try transform(key, value)
            result[transformedKey] = transformedValue
        }
        return result
    }

}
