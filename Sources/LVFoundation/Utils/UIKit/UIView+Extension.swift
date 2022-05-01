//
//  UIView+Extension.swift
//
//  Created by Simeon on 22/02/2018.
//  Copyright © 2018 shimin lu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    /// Generate an still UIImage from UIView
    ///
    /// - Returns: new UIView or nil
    public func toImage() -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(bounds.size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return nil
        }

        layer.render(in: currentContext)
        return UIGraphicsGetImageFromCurrentImageContext()

    }

}
