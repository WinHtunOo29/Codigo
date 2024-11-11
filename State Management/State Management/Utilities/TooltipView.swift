//
//  TooltipView.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import UIKit

class TooltipView: UIView {
    
    private let label = UILabel()
    private let padding: CGFloat = 8
    
    init(text: String) {
        super.init(frame: .zero)
        
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding - 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let pointerSize: CGFloat = 30
        let pointerPath = UIBezierPath()
        pointerPath.move(to: CGPoint(x: bounds.midX - pointerSize, y: bounds.maxY - padding))
        pointerPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY))
        pointerPath.addLine(to: CGPoint(x: bounds.midX + pointerSize, y: bounds.maxY - padding))
        pointerPath.close()
        
        UIColor.white.setFill()
        pointerPath.fill()
    }
}
