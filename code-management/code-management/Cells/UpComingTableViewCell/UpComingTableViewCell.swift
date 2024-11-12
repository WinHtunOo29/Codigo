//
//  UpComingTableViewCell.swift
//  code-management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import UIKit
import SDWebImage
import RealmSwift

class UpComingTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var movieTitleLb: UILabel!
    @IBOutlet weak var releaseDateLb: UILabel!
    @IBOutlet weak var favIcon: UIImageView!
    
    var id = ""
    let realm = try! Realm()
    var favoriteTapped: (() -> Void)?
    var isFavorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let favoriteTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFavorite))
        favIcon.isUserInteractionEnabled = true
        favIcon.addGestureRecognizer(favoriteTapGesture)
        // Configure the view for the selected state
    }
    
    func render(posterImgUrl: String, movielTitle: String, releaseDate: String, id: String) {
        posterImgView.sd_setImage(with: URL(string: posterImgUrl))
        movieTitleLb.text = movielTitle
        releaseDateLb.text = releaseDate
        self.id = id
    }
    
    @objc private func didTapFavorite() {
            // Execute closure when checkbox is tapped
        favoriteTapped?()
    }
}
