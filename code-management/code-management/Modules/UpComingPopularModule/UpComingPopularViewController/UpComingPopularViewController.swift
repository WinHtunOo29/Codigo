//
//  UpComingPopularViewController.swift
//  code-management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit
import RealmSwift

class UpComingPopularViewController: UIViewController {
    
    @IBOutlet weak var upComingTableView: UITableView!
    @IBOutlet weak var upComingTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var popularTableView: UITableView!
    @IBOutlet weak var popularTableViewHeightConstraint: NSLayoutConstraint!
    
    var interactor: UpComingPopularInteractorProtocol?
    var upComingMovieList: [Results] = []
    var popularMovieList: [PopularResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        setUpUpComingTableView()
        setUpPopularTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.interactor?.fetchUpComingMovies()
        self.interactor?.fetchPopularMovies()
        upComingTableView.reloadData()
        popularTableView.reloadData()
    }
    
    private func setupVIP() {
        let interactor = UpComingPopularInteractor()
        let presenter = UpComingPopularPresenter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.view = self
    }
    
    private func setUpUpComingTableView() {
        upComingTableView.delegate = self
        upComingTableView.dataSource = self
        upComingTableView.register(UINib(nibName: "UpComingTableViewCell", bundle: nil), forCellReuseIdentifier: "UpComingTableViewCell")
    }
    
    private func setUpPopularTableView() {
        popularTableView.delegate = self
        popularTableView.dataSource = self
        popularTableView.register(UINib(nibName: "UpComingTableViewCell", bundle: nil), forCellReuseIdentifier: "UpComingTableViewCell")
    }
    
    func getUpComingMovieList(list: [Results]) {
        addUpComingMovieList(movies: list)
        upComingMovieList = list
        upComingTableView.reloadData()
    }
    
    func getPopularMovieList(list: [PopularResults]) {
        addPopularMovieList(movies: list)
        popularMovieList = list
        popularTableView.reloadData()
    }
}

extension UpComingPopularViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == upComingTableView {
            return upComingMovieList.count
        } else {
            return popularMovieList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UpComingTableViewCell", for: indexPath) as? UpComingTableViewCell else {
            return UITableViewCell()
        }
        if tableView == upComingTableView {
            cell.render(posterImgUrl: "https://image.tmdb.org/t/p/original/\(upComingMovieList[indexPath.row].posterPath)", movielTitle: upComingMovieList[indexPath.row].title, releaseDate: upComingMovieList[indexPath.row].releaseDate, id: "\(upComingMovieList[indexPath.row].id)")
        } else {
            cell.render(posterImgUrl: "https://image.tmdb.org/t/p/original/\(popularMovieList[indexPath.row].posterPath)", movielTitle: popularMovieList[indexPath.row].title, releaseDate: popularMovieList[indexPath.row].releaseDate, id: "\(upComingMovieList[indexPath.row].id)")
        }
        cell.favoriteTapped = {
            cell.isFavorite = !cell.isFavorite
            cell.favIcon.image = cell.isFavorite ? UIImage(named: "filledHeart") : UIImage(named: "heart")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == upComingTableView {
            let vc = MovieDetailsRouter.createModule(movieId: upComingMovieList[indexPath.row].id)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = MovieDetailsRouter.createModule(movieId: popularMovieList[indexPath.row].id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension UpComingPopularViewController {
    func addUpComingMovieList(movies: [Results]) {
        let realm = try! Realm()
        
        for i in 0..<movies.count {
            do {
                try realm.write {
                    let movie = UpComingMovies()
                    
                    movie.id = String(movies[i].id)
                    movie.title = movies[i].title
                    movie.releasedDate = movies[i].releaseDate
                    movie.overview = movies[i].overview
                    movie.imagePath = movies[i].posterPath
                    
                    realm.add(movie)
                }
            } catch {
                print("Something went wrong \(error)")
            }
        }
    }
    
    func addPopularMovieList(movies: [PopularResults]) {
        let realm = try! Realm()
        
        for i in 0..<movies.count {
            do {
                try realm.write {
                    let movie = PopularMovies()
                    
                    movie.id = String(movies[i].id)
                    movie.title = movies[i].title
                    movie.releasedDate = movies[i].releaseDate
                    movie.overview = movies[i].overview
                    movie.imagePath = movies[i].posterPath
                    
                    realm.add(movie)
                }
            } catch {
                print("Something went wrong \(error)")
            }
        }
    }
    
//    func fetchMovies() {
//        let realm = try! Realm()
//        let popularMovies = realm.objects(PopularMovies.self)
//        let upcomingMovies = realm.objects(UpComingMovies.self)
//        
//        var savedPopularMovies: [PopularResults] = [PopularResults]()
//        var savedUpcomingMovies: [Results] = [Results]()
//        
//        self.popularMovieList = Array(upcomingMovies.compactMap { try? PopularResults(from: $0) })
//        self.upComingMovieList = savedUpcomingMovies
//    }
}
