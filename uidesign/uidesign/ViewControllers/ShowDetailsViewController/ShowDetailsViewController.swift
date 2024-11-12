//
//  ShowDetailsViewController.swift
//  uidesign
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit

class ShowDetailsViewController: UIViewController {
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var textLb1: UILabel!
    @IBOutlet weak var textLb2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIs()
    }
    
    private func setupUIs() {
        uiView.layer.borderWidth = 1.0
        uiView.layer.borderColor = UIColor.lightGray.cgColor
        uiView.layer.cornerRadius = 10.0
        
        textLb1.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        textLb2.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
