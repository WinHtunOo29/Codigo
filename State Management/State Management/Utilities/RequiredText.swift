//
//  RequiredText.swift
//  State Management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit

struct RequiredText {
    func makeStarRed(mainString: String, label: UILabel) {
        let star = "*"
        let range = (mainString as NSString).range(of: star)
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        label.attributedText = mutableAttributedString
    }
}
