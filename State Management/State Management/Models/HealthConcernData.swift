//
//  HealthConcernModel.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation

struct HealthConcernData: Codable {
    let data: [HealthConcern]
}

struct HealthConcern: Codable {
    let id: Int
    let name: String
}

