//
//  ShowCollectionViewCell.swift
//  uidesign
//
//  Created by Win Htun Oo on 12/11/2024.
//

import UIKit

class ShowCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        timeView.layer.borderWidth = 1
        timeView.layer.cornerRadius = 10
    }

}
