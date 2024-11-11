//
//  HealthConcernsCollectionViewCell.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import UIKit

class HealthConcernsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var healthConcernBg: UIView!
    @IBOutlet weak var healthConcernLb: UILabel!
    override var isSelected: Bool {
        didSet {
            self.healthConcernBg.backgroundColor = isSelected ? .init(red: 1/255, green: 54/255, blue: 145/255, alpha: 1.0) : .clear
            self.healthConcernLb.textColor = isSelected ? .white : .init(red: 1/255, green: 54/255, blue: 145/255, alpha: 1.0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        // Initial cell setup
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1.0
        self.healthConcernBg.layer.cornerRadius = 15.0
        self.healthConcernBg.layer.borderWidth = 1.0
        self.healthConcernBg.backgroundColor = .clear
        self.layer.masksToBounds = true
        self.healthConcernBg.layer.masksToBounds = true
        self.healthConcernLb.textColor = .init(red: 1/255, green: 54/255, blue: 145/255, alpha: 1.0)
    }
}
