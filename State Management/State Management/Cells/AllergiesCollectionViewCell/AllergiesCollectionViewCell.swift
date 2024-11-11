//
//  AllergiesCollectionViewCell.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import UIKit

class AllergiesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedAllergyLb: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        // Initial cell setup
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
    }

}
