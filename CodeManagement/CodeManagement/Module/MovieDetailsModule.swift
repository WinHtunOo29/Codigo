//
//  MovieDetailsModule.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit

class MovieDetailsModule {
    func createModule(id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        view.movieId = id
        return view
    }
}
