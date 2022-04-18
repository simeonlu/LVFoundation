//
//  String+ext.swift
//
//  Created by Shimin lyu on 22/1/2021.
//

import UIKit

extension String {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
}

// MARK: - Base64
extension String {
    func toBase64Image() -> UIImage? {
        guard let data = toBase64Data() else { return nil }
        return UIImage(data: data)
    }
    
    func toBase64Data() -> Data? {
        Data(base64Encoded: self, options: .ignoreUnknownCharacters)
    }
}
