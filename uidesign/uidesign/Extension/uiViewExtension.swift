//
//  uiViewExtension.swift
//  uidesign
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit

extension UIView {
    func makeCircular(borderWidth: CGFloat = 5.0, borderColor: UIColor = .lightGray) {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func makeRoundedCornerWithShadow(borderWidth: CGFloat = 1.0, color: UIColor = .lightGray, opacity: Float = 0.5, offSet: CGSize, shadowRadius: CGFloat = 8, scale: Bool = true) {
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = borderWidth
    
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = shadowRadius

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
