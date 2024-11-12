//
//  UpComingPopularPresenter.swift
//  code-management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation

protocol UpComingPopularPresenterProtocol {
    var view: UpComingPopularViewController? { get set }
    func getUpComingMovieList(list: [Results])
    func getPopularMovieList(list: [PopularResults])
}

class UpComingPopularPresenter: UpComingPopularPresenterProtocol {
    var view: UpComingPopularViewController?
    
    func getUpComingMovieList(list: [Results]) {
        self.view?.getUpComingMovieList(list: list)
    }
    
    func getPopularMovieList(list: [PopularResults]) {
        self.view?.getPopularMovieList(list: list)
    }
}
