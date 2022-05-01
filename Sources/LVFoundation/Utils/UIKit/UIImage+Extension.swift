//
//  UIImage+Extension.swift
//
//  Created by Simeon on 22/02/2018.
//  Copyright © 2018 shimin lu. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    /// Resize the image according to percentage required
    ///
    /// - Parameter percentage: percentage expected
    /// - Returns: new image resized
    public func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// Resize image according to file size
    ///
    /// - Parameter mgb: expected file size
    /// - Returns: new image resized
    public func resizedTo(mgb: UInt) -> UIImage? {
        guard let imageData = self.pngData() else { return nil }

        var resizingImage = self
        let kBUnit = 1024.0
        var imageSizeKB = Double(imageData.count) / kBUnit
        while imageSizeKB > Double(mgb) * kBUnit {
            guard let resizedImage = resizingImage.resized(withPercentage: 0.8),
                let imageData = resizedImage.pngData()
                else { return nil }

            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / kBUnit
        }

        return resizingImage
    }

    /// Encode PNG image to base64
    ///
    /// - Returns: base64 string of the image or nil
    public func encodeBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString()
    }

}
