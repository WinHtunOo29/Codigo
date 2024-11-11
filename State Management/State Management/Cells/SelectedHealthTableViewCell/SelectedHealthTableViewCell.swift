//
//  SelectedHealthTableViewCell.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import UIKit

class SelectedHealthTableViewCell: UITableViewCell {

    @IBOutlet weak var healthLb: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        healthLb.padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        healthLb.backgroundColor = .init(red: 1/255, green: 54/255, blue: 145/255, alpha: 1.0)
        healthLb.textColor = .white
        healthLb.numberOfLines = 0
        healthLb.lineBreakMode = .byWordWrapping
    }
    
}
