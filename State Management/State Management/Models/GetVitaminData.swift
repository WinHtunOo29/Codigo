//
//  GetVitaminData.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation

struct DailyExposure: Codable {
    var is_daily_exposure: Bool?
}

struct Smoke: Codable {
    var is_smoke: Bool?
}

struct Alcohol: Codable {
    var alcohol: String?
}
