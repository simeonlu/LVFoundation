//
//  File.swift
//  
//
//  Created by Shimin lyu on 26/3/2023.
//

import Foundation

public enum USD: CurrencyType {
    public static var code: String {
        return "USD"

    }
    public static var symbol: String {
        return "$"

    }
    public static var name: String {
        return "US dollar"

    }
}

public enum CNY: CurrencyType {
    public static var code: String {
        return "CNY"

    }
    public static var symbol: String {
        return "¥"

    }
    public static var name: String {
        return "Chinese Yuan Renminbi"

    }
}

public enum EUR: CurrencyType {
    public static var code: String {
        return "EUR"

    }
    public static var symbol: String {
        return "€"

    }
    public static var name: String {
        return "Euro"

    }
}
public enum HKD: CurrencyType {
    public static var code: String {
        return "HKD"

    }
    public static var symbol: String {
        return "HK$"

    }
    public static var name: String {
        return "Hong Kong Dollar"

    }
}

public enum GBP: CurrencyType {
    public static var code: String {
        return "GBP"

    }
    public static var symbol: String {
        return "£"

    }
    public static var name: String {
        return "British Pound"

    }
}

public enum JPY: CurrencyType {
    public static var code: String {
        return "JPY"

    }
    public static var symbol: String {
        return "¥"

    }
    public static var name: String {
        return "Japanese Yen"

    }
}
