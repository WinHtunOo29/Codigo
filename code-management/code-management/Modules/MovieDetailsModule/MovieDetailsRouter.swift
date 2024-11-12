//
//  MovieDetailsRouter.swift
//  code-management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit

protocol MovieDetailsRouterProtocol {
    static func createModule(movieId: Int) -> UIViewController
}

class MovieDetailsRouter: MovieDetailsRouterProtocol {
    static func createModule(movieId: Int) -> UIViewController {
        let view = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        let presenter = MovieDetailsPresenter()
        let interactor = MovieDetailsInteractor()
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        view.movieId = movieId
        return view
    }
}
