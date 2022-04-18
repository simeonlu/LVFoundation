//
//  Sequence+Ext.swift
//
//  Created by Shimin lyu on 21/3/2020.
//

import Foundation

// find the 'M' smallest
extension Sequence {
    func smallest(_ m: Int, by isInAsecOrder: (Element, Element) -> Bool) -> [Element] {
      
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
    func min(_ m: Int) -> [Element] {
        smallest(m, by: <)
    }
    func max(_ m: Int) -> [Element] {
        smallest(m, by: >)
    }
}

extension Array where Element: Comparable {
    func binarySearch(key: Element) -> Int? {
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
