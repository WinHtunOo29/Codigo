//
//  MovieDetailsViewController.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var movieTitleLb: UILabel!
    @IBOutlet weak var releasedDateLb: UILabel!
    @IBOutlet weak var overviewLb: UILabel!
    
    var viewModel: MovieDetailsViewModel?
    var movieId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIs()
    }
    
    func setupUIs() {
        viewModel = MovieDetailsViewModel(id: movieId)
        if let image = UIImage(data: viewModel?.image ?? Data()) {
            DispatchQueue.main.async {
                self.posterImgView.image = image
            }
        }
        movieTitleLb.text = viewModel?.title ?? ""
        releasedDateLb.text = viewModel?.releasedDate ?? ""
        overviewLb.text = viewModel?.overview ?? ""
    }
}
