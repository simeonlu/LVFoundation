//
//  File.swift
//  
//
//  Created by Shimin lyu on 6/1/2024.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
