//
//  JsonReader.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import Foundation

class JsonReader {
    
    func read(fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            return nil
        }
    }
    
}
