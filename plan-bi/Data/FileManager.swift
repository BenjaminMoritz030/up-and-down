//
//  FileManager.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 19.09.24.
//

import Foundation

class FileManager {
    
    static func loadJSON<T: Codable>(with fileName: String) -> T? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("File doesn't exist!")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            
            return jsonData.self
        } catch {
            print("Error: here\(error)")
        }
        
        return nil
    }
}
