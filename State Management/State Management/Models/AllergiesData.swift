//
//  AllergiesData.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation

struct AllergiesData: Codable {
    let data: [Allergies]
}

struct Allergies: Codable {
    let id: Int
    let name: String
}
