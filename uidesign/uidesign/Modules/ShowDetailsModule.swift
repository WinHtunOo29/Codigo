//
//  ShowDetailsModule.swift
//  uidesign
//
//  Created by Win Htun Oo on 13/11/2024.
//

import Foundation
import UIKit

class ShowDetailsModule {
    func createModule() -> UIViewController {
        let view = ShowDetailsViewController(nibName: "ShowDetailsViewController", bundle: nil)
        return view
    }
}
