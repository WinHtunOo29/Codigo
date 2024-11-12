//
//  MovieTableViewCell.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import UIKit
import RealmSwift

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var movieTitleLb: UILabel!
    @IBOutlet weak var releasedDateLb: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!

    var id = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteBtnTapped(_ sender: UIButton) {
        let realm = try! Realm()
        let movies = realm.objects(Movies.self).filter("id == %@", id)
        let movie = movies.first
        do {
            try realm.write {
                movie?.isFavourite = !(movie?.isFavourite ?? true)
                if movie?.isFavourite ?? false {
                    sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } else {
                    sender.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func render(id: Int, imgUrl: String, movieTitle: String, releasedDate: String) {
        self.id = String(id)
        let imageUrl = "https://image.tmdb.org/t/p/original/\(imgUrl)"
        let url = URL(string: imageUrl)!
        self.showSavedImage(id: String(id))
        posterImgView.loadImg(from: url, id: String(id))
        self.movieTitleLb.text = movieTitle
        self.releasedDateLb.text = releasedDate
    }
    
    func showSavedImage(id: String) {
        let realm = try! Realm()
        let movies = realm.objects(Movies.self).filter("id == %@", id)
        let movie: Movies? = movies.first
        
        if movie?.isFavourite ?? false {
            favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        if let image = UIImage(data: movie?.image ?? Data()) {
            DispatchQueue.main.async {
                self.posterImgView.image = image
            }
        } else {
            self.posterImgView.image = UIImage()
        }
    }
}
