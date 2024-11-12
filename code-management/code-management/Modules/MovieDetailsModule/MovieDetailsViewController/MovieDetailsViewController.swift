//
//  MovieDetailsViewController.swift
//  code-management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var movieTitleLb: UILabel!
    @IBOutlet weak var overviewLb: UILabel!
    
    var interactor: MovieDetailsInteractorProtocol?
    var movieId: Int?
    var movieDetails: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let id = movieId {
            self.interactor?.fetchMovieDetails(movieId: id)
        }
    }
    
    func getMovieDetails(details: MovieDetail) {
        movieDetails = details
        if let posterPath = self.movieDetails?.posterPath {
            self.posterImgView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(posterPath)"))
        }
       
        movieTitleLb.text = movieDetails?.title
        overviewLb.text = movieDetails?.overview
    }
}
