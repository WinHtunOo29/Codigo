//
//  GetVitaminRouter.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation
import UIKit

protocol GetVitaminRouterProtocol {
    static func createModule(selectedHealthConcerns: [HealthConcern], selectedDiets: [Diet], selectedAllergies: [Allergies]) -> UIViewController
}

class GetVitaminRouter: GetVitaminRouterProtocol {
    static func createModule(selectedHealthConcerns: [HealthConcern], selectedDiets: [Diet], selectedAllergies: [Allergies]) -> UIViewController {
        let view = GetVitaminViewController(nibName: "GetVitaminViewController", bundle: nil)
        view.selectedHealthConcerns = selectedHealthConcerns
        view.selectedDiets = selectedDiets
        view.selectedAllergies = selectedAllergies
        return view
    }
}
