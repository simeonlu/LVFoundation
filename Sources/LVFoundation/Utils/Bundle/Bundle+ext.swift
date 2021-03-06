//
//  Bundle+ext.swift
//  ExtensionUtils
//
//  Created by Shimin lyu on 7/3/2020.
//  Copyright © 2020 shimin lu. All rights reserved.
//

import Foundation
public enum Configuration {
    public enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    /// Get value from userInfo plist file
    /// - Parameter key: key of the value
    /// - Throws: Error
    /// - Returns: the value in plist or throws an error
    public static func value<T>(for key: String, in bundle: Bundle = .main) throws -> T where T: LosslessStringConvertible {
        guard let object = bundle.object(forInfoDictionaryKey: key) else {
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
    
    public static var versionNumber: String {
        return (try? value(for: "CFBundleShortVersionString")) ?? "--"
    }
    
    public static var buildNumber: String {
        return (try? value(for: "CFBundleVersion")) ?? "--"
    }
}
