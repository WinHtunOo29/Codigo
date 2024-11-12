//
//  MovieDetailsInteractor.swift
//  code-management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation

protocol MovieDetailsInteractorProtocol {
    var presenter: MovieDetailsPresenterProtocol? { get set }
    func fetchMovieDetails(movieId: Int)
}

class MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    var presenter: MovieDetailsPresenterProtocol?
    
    var networkManager = NetworkManager.shared
    
    func fetchMovieDetails(movieId: Int) {
        networkManager.request(endpoint: "/movie/\(movieId)") { (result: Result<MovieDetail, APIError>) in
            switch result {
            case .success(let details):
                self.presenter?.getMovieDetails(details: details)
            case .failure(let error):
                print("-----", error)
            }
        }
    }
}
