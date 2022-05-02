//
//  File.swift
//  
//
//  Created by Shimin lyu on 2/5/2022.
//

import Foundation

func loadFile(fileName: String, fileType: String = "json") -> Data? {
    
    let bundle = Bundle(for: type(of: self))
    let filePath = bundle.path(forResource: fileName, ofType: fileType)
    
    guard let path = filePath else { return nil }
    
    let url = URL(fileURLWithPath: path)
    return  try? Data(contentsOf: url)
}
