//
//  Optional+Extension.swift
//
//  Created by shimin lu on 23/1/2018.
//

import Foundation

extension Optional {
    /// Returns true if the optional is empty
    public var isNone: Bool {
        return self  == nil
    }

    /// Returns true if the optional is not empty
    public var isSome: Bool {
        return self != nil
    }
}

extension Optional {
   
    ///
    /// - Parameter default: default value
    /// - Returns: Return the value of the Optional or the `default` parameter
    public func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }

    /// get the unwrapped value of the optional *or* else
    /// I.e. optional.or(else: print("Arrr"))
    /// - Parameter else: expression `else
    /// - Returns: unwrapped value or result of expression
    public func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }

    /// I.e. optional.or(else: {
    /// ... do a lot of stuff
    /// })
    /// - Parameter else: the closure `else`
    /// - Returns: Returns the unwrapped value of the optional *or* the result of calling the closure
    public func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }

    /// Returns the unwrapped contents of the optional if it is not empty
    /// If it is empty, throws exception `throw`
    /// - Parameter exception: error
    /// - Throws: throws exception `throw`
    /// - Returns: the unwrapped contents of the optional if it is not empty
    public func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }
}
extension Optional {
    /// Executes the closure `some` if and only if the optional has a value
    public func on(some: () throws -> Void) rethrows {
        if self != nil { try some() }
    }

    /// Executes the closure `none` if and only if the optional has no value
    public func on(none: () throws -> Void) rethrows {
        if self == nil { try none() }
    }
}
