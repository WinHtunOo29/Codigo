//
//  DietsTableViewCell.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import UIKit

class DietsTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxImgView: UIImageView!
    @IBOutlet weak var dietsLb: UILabel!
    @IBOutlet weak var tooltipImgView: UIImageView!
    
    var checkboxTapped: (() -> Void)?
    var toolTipTapped: (() -> Void)?
    var isChecked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkBoxImgView.image = UIImage(named: "uncheckBox")
        let checkBoxTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        checkBoxImgView.isUserInteractionEnabled = true
        checkBoxImgView.addGestureRecognizer(checkBoxTapGesture)
        
        let toolTipTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapToolTip))
        tooltipImgView.isUserInteractionEnabled = true
        tooltipImgView.addGestureRecognizer(toolTipTapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func didTapCheckbox() {
            // Execute closure when checkbox is tapped
        checkboxTapped?()
    }
    
    @objc private func didTapToolTip() {
        toolTipTapped?()
    }
}
