//
//  DietRouter.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation
import UIKit

protocol DietRouterProtocol {
    static func createModule(selectedHealthConcerns: [HealthConcern]) -> UIViewController
}

class DietRouter: DietRouterProtocol {
    static func createModule(selectedHealthConcerns: [HealthConcern]) -> UIViewController {
        let view = DietViewController(nibName: "DietViewController", bundle: nil)
        view.selectedHealthConcerns = selectedHealthConcerns
        return view
    }
}
