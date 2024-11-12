//
//  MovieListViewModel.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit
import Combine
import RealmSwift

class MovieListViewModel: ObservableObject {
    var upcomingMoviesSubscriptions: AnyCancellable?
    var popularMoviesSubscriptions: AnyCancellable?
    var errorMsg = ""
    var viewController: UIViewController?
    
    var reloadUpcomingTableView: (()->())?
    var reloadPopularTableView: (()->())?
    var showError: (()->())?
    var startLoading: (()->())?
    var stopLoading: (()->())?
    
    var upcomingMoviesList: [Results] = [Results] () {
        didSet {
            self.stopLoading?()
            self.reloadUpcomingTableView?()
        }
    }
    
    var popularMoviesList: [Results] = [Results] () {
        didSet {
            self.stopLoading?()
            self.reloadPopularTableView?()
        }
    }
    
    func getMovieList() {
        upcomingMoviesSubscriptions = MoviesList.fetchUpcomingMovies()
        .receive(on: DispatchQueue.global())
        .sink { error in
            switch error {
            case .finished:
                print("Success Fetching Upcoming Movie List Call")
            case .failure(let error):
                self.errorMsg = error.get()
                self.showError?()
            }
        } receiveValue: { movieList in
            self.upcomingMoviesList = movieList.results ?? []
            self.storeMovie(movieList: self.upcomingMoviesList)
        }
        
        popularMoviesSubscriptions = MoviesList.fetchCPopularMovies()
        .receive(on: DispatchQueue.global())
        .sink { error in
            switch error {
            case .finished:
                print("Success Fetching Popular Movie List Call")
            case .failure(let error):
                self.errorMsg = error.get()
                self.showError?()
            }
        } receiveValue: { movieList in
            self.popularMoviesList = movieList.results ?? []
            self.storeMovie(movieList: self.popularMoviesList, isPopular: true)
        }
    }
    
    func storeMovie(movieList: [Results], isPopular: Bool = false) {
        let realm = try! Realm()
        for i in 0..<movieList.count {
            do {
                try realm.write {
                    let movie = Movies()
                    movie.id = String(movieList[i].id ?? 0)
                    movie.title = movieList[i].title ?? ""
                    movie.releasedDate = movieList[i].releaseDate ?? ""
                    movie.overview = movieList[i].overview ?? ""
                    movie.isPopular = isPopular
                    realm.add(movie)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func fetchMoviesFromRealm() {
        let realm = try! Realm()
        let upcomingMovieList = realm.objects(Movies.self).filter("isPopular == false")
        let popularMovieList = realm.objects(Movies.self).filter("isPopular == true")
        
        var storedUpcomingMovieList: [Results] = []
        var storedPopularMovieList: [Results] = []
        
        for i in upcomingMovieList {
            var movie = Results()
            movie.id = Int(i.id)
            movie.title = i.title
            movie.releaseDate = i.releasedDate
            storedUpcomingMovieList.append(movie)
        }
        self.upcomingMoviesList = storedUpcomingMovieList
        
        for i in popularMovieList {
            var movie = Results()
            movie.id = Int(i.id)
            movie.title = i.title
            movie.releaseDate = i.releasedDate
            storedPopularMovieList.append(movie)
        }
        self.popularMoviesList = storedPopularMovieList
    }
    
    func goToDetails(id: String) {
        let view = MovieDetailsModule().createModule(id: id)
        view.modalPresentationStyle = .formSheet
        viewController?.present(view, animated: true)
    }
}
