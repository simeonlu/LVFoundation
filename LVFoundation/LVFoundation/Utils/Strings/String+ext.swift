//
//  String+ext.swift
//
//  Created by Shimin lyu on 22/1/2021.
//

import UIKit

extension String {
    public var isNotEmpty: Bool {
        !self.isEmpty
    }
}

// MARK: - Base64
extension String {
    public func toBase64Image() -> UIImage? {
        guard let data = toBase64Data() else { return nil }
        return UIImage(data: data)
    }
    
    public func toBase64Data() -> Data? {
        Data(base64Encoded: self, options: .ignoreUnknownCharacters)
    }
}
