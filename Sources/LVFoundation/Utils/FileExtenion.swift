//
//  File.swift
//  
//
//  Created by Shimin lyu on 2/5/2022.
//

import Foundation

func loadFile(bundle: Bundle, fileName: String, fileType: String = "json") -> Data? {
    
    let filePath = bundle.path(forResource: fileName, ofType: fileType)
    
    guard let path = filePath else { return nil }
    
    let url = URL(fileURLWithPath: path)
    return  try? Data(contentsOf: url)
}
