//
//  DietData.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation

struct DietData: Codable {
    let data: [Diet]
}

struct Diet: Codable {
    let id: Int
    let name: String
    let tool_tip: String?
}
