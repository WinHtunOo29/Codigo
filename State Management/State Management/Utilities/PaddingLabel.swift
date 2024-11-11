//
//  PaddingLabel.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation
import UIKit

class PaddingLabel: UILabel {
    
    var padding = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    var cornerRadius: CGFloat = 18 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: padding)
        super.drawText(in: insetRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
