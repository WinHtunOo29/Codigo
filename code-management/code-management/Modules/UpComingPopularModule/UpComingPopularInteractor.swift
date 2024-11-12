//
//  UpComingPopularInteractor.swift
//  code-management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation

protocol UpComingPopularInteractorProtocol {
    var presenter: UpComingPopularPresenterProtocol? { get set }
    func fetchUpComingMovies()
    func fetchPopularMovies()
}

class UpComingPopularInteractor: UpComingPopularInteractorProtocol {
    var presenter: UpComingPopularPresenterProtocol?
    let networkManager = NetworkManager.shared
    
    func fetchUpComingMovies() {
        networkManager.request(endpoint: "/movie/upcoming") { (result: Result<UpComingList, APIError>) in
            switch result {
            case .success(let upcomingList):
                self.presenter?.getUpComingMovieList(list: upcomingList.results)
            case .failure(let error):
                print("-----upcoming", error)
            }
        }
    }
    
    func fetchPopularMovies() {
        networkManager.request(endpoint: "/movie/popular") { (result: Result<PopularList, APIError>) in
            switch result {
            case .success(let popularList):
                self.presenter?.getPopularMovieList(list: popularList.results)
            case .failure(let error):
                print("-----popular", error)
            }
        }
    }
}
