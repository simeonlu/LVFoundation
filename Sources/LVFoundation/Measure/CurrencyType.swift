//
//  Currency.swift
//
//  Created by Simeon on 19/10/2018.
//  Copyright © 2018 shimin lu. All rights reserved.
//

import Foundation

public protocol CurrencyType {
    static var code: String { get }
    static var symbol: String { get }
    static var name: String { get }
}

public struct Money<C: CurrencyType>: Equatable {
    typealias Currency = C
    var amount: Decimal
    
    init(_ amount: Decimal) {
        self.amount = amount
    }

    var currency: CurrencyType {
        return Currency.self as! C
    }
}

extension Money: Comparable {
    public static func < (lhs: Money<C>, rhs: Money<C>) -> Bool {
        lhs.amount < rhs.amount
    }
}

extension Money: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(Decimal(value))
    }
}

extension Money: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(Decimal(value))
    }
}

public extension Money {
    static func + (lhs: Money<C>, rhs: Money<C>) -> Self {
        return Money<C>(lhs.amount + rhs.amount)
    }
    static func += ( lhs: inout Money<C>, rhs: Money<C>) {
        lhs.amount += rhs.amount
    }
    static func - (lhs: Money<C>, rhs: Money<C>) -> Self {
        return Money<C>(lhs.amount - rhs.amount)
    }
    static func -= (lhs: inout Money<C>, rhs: Money<C>) {
        lhs.amount -= rhs.amount
    }

    static func * (lhs: Money<C>, rhs: Decimal) -> Self {
        return Money<C>(lhs.amount * rhs)
    }
    static func * (lhs: Decimal, rhs: Money<C>) -> Self {
        return Money<C>(lhs * rhs.amount)
    }
    static func *= (lhs: inout Money<C>, rhs: Decimal) {
        return lhs.amount *= rhs
    }

    static prefix func - (value: Money<C>) -> Money<C> {
        return Money<C>(-value.amount)
    }

}

protocol UnidirectionalCurrencyConverter {
    associatedtype Fixed: CurrencyType
    associatedtype Variable: CurrencyType
    var rate: Decimal { get set }

}

extension UnidirectionalCurrencyConverter {
   public func convert(_ value: Money<Fixed>) -> Money<Variable> {
        return Money<Variable>(value.amount * rate) }
}

protocol BidirectionalCurrencyConverter: UnidirectionalCurrencyConverter {}

extension BidirectionalCurrencyConverter {
    public func convert(_ value: Money<Variable>) -> Money<Fixed> {
        return Money<Fixed>(value.amount / rate) }
}

public struct CurrencyPair<Fixed: CurrencyType, Variable: CurrencyType>: BidirectionalCurrencyConverter {
    
    var rate: Decimal
    init(rate: Decimal) {
        precondition(rate > 0)
        self.rate = rate
    }
}
