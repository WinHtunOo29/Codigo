//
//  DataManager.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation

class DataManager {
    func loadJSON<T: Codable>(filename: String, type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("File not found: \(filename)")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(type, from: data)
            return decodedData
        } catch {
            print("Error decoding JSON from file \(filename): \(error)")
            return nil
        }
    }
}
