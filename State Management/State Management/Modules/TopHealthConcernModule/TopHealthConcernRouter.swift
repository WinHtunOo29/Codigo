//
//  TopHealthConcernRouter.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import UIKit

protocol TopHealthConcernRouterProtocol {
    static func createModule() -> UIViewController
}

class TopHealthConcernRouter: TopHealthConcernRouterProtocol {
    static func createModule() -> UIViewController {
        let view = TopHealthConcernViewController(nibName: "TopHealthConcernViewController", bundle: nil)
        return view
    }
}
