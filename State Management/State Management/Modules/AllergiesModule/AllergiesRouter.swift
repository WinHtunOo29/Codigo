//
//  AllergiesRouter.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation
import UIKit

protocol AllergiesRouterProtocol {
    static func createModule(selectedHealthConcerns: [HealthConcern], selectedDiets: [Diet]) -> UIViewController
}

class AllergiesRouter: AllergiesRouterProtocol {
    static func createModule(selectedHealthConcerns: [HealthConcern], selectedDiets: [Diet]) -> UIViewController {
        let view = AllergiesViewController(nibName: "AllergiesViewController", bundle: nil)
        view.selectedHealthConcerns = selectedHealthConcerns
        view.selectedDiets = selectedDiets
        return view
    }
}
