//
//  Currency.swift
//
//  Created by Simeon on 19/10/2018.
//  Copyright © 2018 shimin lu. All rights reserved.
//

import Foundation

protocol CurrencyType {
    static var code: String { get }
    static var symbol: String { get }
    static var name: String { get }
}

struct Money<C: CurrencyType>: Equatable {
    typealias Currency = C
    var amount: Decimal
    
    init(_ amount: Decimal) {
        self.amount = amount
    }

    var currency: CurrencyType {
        return Currency.self as! CurrencyType
    }
}

extension Money: Comparable {
    static func < (lhs: Money<C>, rhs: Money<C>) -> Bool {
        lhs.amount < rhs.amount
    }
}

extension Money: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.init(Decimal(value))
    }
}

extension Money: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(Decimal(value))
    }
}

extension Money {
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

    public static prefix func - (value: Money<C>) -> Money<C> {
        return Money<C>(-value.amount)
    }

}

protocol UnidirectionalCurrencyConverter {
    associatedtype Fixed: CurrencyType
    associatedtype Variable: CurrencyType
    var rate: Decimal { get set }

}

extension UnidirectionalCurrencyConverter {
    func convert(_ value: Money<Fixed>) -> Money<Variable> {
        return Money<Variable>(value.amount * rate) }
}

protocol BidirectionalCurrencyConverter: UnidirectionalCurrencyConverter {}

extension BidirectionalCurrencyConverter {
    func convert(_ value: Money<Variable>) -> Money<Fixed> {
        return Money<Fixed>(value.amount / rate) }
}

struct CurrencyPair<Fixed: CurrencyType, Variable: CurrencyType>: BidirectionalCurrencyConverter {
    
    var rate: Decimal
    init(rate: Decimal) {
        precondition(rate > 0)
        self.rate = rate
    }
}
