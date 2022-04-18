//
//  UIColor+Extension.swift
//
//  Created by Simeon on 22/02/2018.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

extension UIColor {
    
    /// Color to Hex string
    public var toHexString: String {
        var aRed: CGFloat = 0
        var aGreen: CGFloat = 0
        var aBlue: CGFloat = 0
        var aAlpha: CGFloat = 0
        
        self.getRed(&aRed, green: &aGreen, blue: &aBlue, alpha: &aAlpha)
        
        return String(
            format: "%02X%02X%02X",
            Int(aRed * 0xff),
            Int(aGreen * 0xff),
            Int(aBlue * 0xff)
        )
    }
}
