//
//  Bundle+ext.swift
//  ExtensionUtils
//
//  Created by Shimin lyu on 7/3/2020.
//  Copyright © 2020 shimin lu. All rights reserved.
//

import Foundation
enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    /// Get value from userInfo plist file
    /// - Parameter key: key of the value
    /// - Throws: Error
    /// - Returns: the value in plist or throws an error
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
