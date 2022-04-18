//
//  LocalizedKey.swift
//
//  Created by Simeon Lyu on 27/1/2021.
//

import Foundation

/// Localise string wrapper
/// Usage example:
///
///   enum NetworkErrorText: LocalizedString {
///     case timeOut = "The request timed out"
///     ...
///   }
///   ...
///   let message = NetworkErrorText.timeOut.localizedString
///
///

public struct LocalizedString: ExpressibleByStringLiteral, Equatable {
    
    public let value: String
    
    public init(key: String) {
        self.value = NSLocalizedString(key, comment: key)
    }
    
    public init(stringLiteral value: String) {
        self.init(key: value)
    }
}

public func ==(lhs:LocalizedString, rhs:LocalizedString) -> Bool {
    return lhs.value == rhs.value
}

extension ExpressibleByUnicodeScalarLiteral where Self: ExpressibleByStringLiteral, Self.StringLiteralType == String {
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

extension ExpressibleByExtendedGraphemeClusterLiteral where Self: ExpressibleByStringLiteral, Self.StringLiteralType == String {
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

extension RawRepresentable where RawValue == LocalizedString {
    public var localizedString: String {
        return self.rawValue.value
    }
    public init?(localizedString: String) {
        self.init(rawValue: LocalizedString(key: localizedString))
    }
}
