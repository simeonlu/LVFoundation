//
//  File.swift
//  
//
//  Created by Shimin lyu on 26/3/2023.
//

import Foundation

enum USD: CurrencyType {
    static var code: String {
        return "USD"

    }
    static var symbol: String {
        return "$"

    }
    static var name: String {
        return "US dollar"

    }
}

enum CNY: CurrencyType {
    static var code: String {
        return "CNY"

    }
    static var symbol: String {
        return "¥"

    }
    static var name: String {
        return "Chinese Yuan Renminbi"

    }
}

enum EUR: CurrencyType {
    static var code: String {
        return "EUR"

    }
    static var symbol: String {
        return "€"

    }
    static var name: String {
        return "Euro"

    }
}
enum HKD: CurrencyType {
    static var code: String {
        return "HKD"

    }
    static var symbol: String {
        return "HK$"

    }
    static var name: String {
        return "Hong Kong Dollar"

    }
}

enum GBP: CurrencyType {
    static var code: String {
        return "GBP"

    }
    static var symbol: String {
        return "£"

    }
    static var name: String {
        return "British Pound"

    }
}

enum JPY: CurrencyType {
    static var code: String {
        return "JPY"

    }
    static var symbol: String {
        return "¥"

    }
    static var name: String {
        return "Japanese Yen"

    }
}
