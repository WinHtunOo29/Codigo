//
//  HomeViewController.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var getStartedBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIs()
    }
    
    private func setUpUIs() {
        getStartedBtn.layer.borderWidth = 1
        getStartedBtn.layer.cornerRadius = 15
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func getStartedBtnTapped(_ sender: Any) {
        let vc = TopHealthConcernRouter.createModule()
        navigationController?.pushViewController(vc, animated: true)
    }
}
