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

struct LocalizedString: ExpressibleByStringLiteral, Equatable {
    
    let value: String
    
    init(key: String) {
        self.value = NSLocalizedString(key, comment: key)
    }
    
    init(stringLiteral value: String) {
        self.init(key: value)
    }
}

func ==(lhs:LocalizedString, rhs:LocalizedString) -> Bool {
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
    var localizedString: String {
        return self.rawValue.value
    }
    init?(localizedString: String) {
        self.init(rawValue: LocalizedString(key: localizedString))
    }
}
