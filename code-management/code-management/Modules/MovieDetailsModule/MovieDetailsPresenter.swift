//
//  MovieDetailsPresenter.swift
//  code-management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation

protocol MovieDetailsPresenterProtocol {
    var view: MovieDetailsViewController? { get set }
    func getMovieDetails(details: MovieDetail)
}

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    var view: MovieDetailsViewController?
    
    func getMovieDetails(details: MovieDetail) {
        self.view?.getMovieDetails(details: details)
    }
}
