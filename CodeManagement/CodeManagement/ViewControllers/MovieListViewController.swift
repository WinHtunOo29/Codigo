//
//  MovieListViewController.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var popularTableView: UITableView!
    
    var viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewController = self
        setupUpcomingTableView()
        setupPopularTableView()
        viewModel.fetchMoviesFromRealm()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUpcomingTableView() {
        upcomingTableView.dataSource = self
        upcomingTableView.delegate = self
        upcomingTableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    func setupPopularTableView() {
        popularTableView.dataSource = self
        popularTableView.delegate = self
        popularTableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    func setupViewModel() {
        
        viewModel.reloadUpcomingTableView = {
            DispatchQueue.main.async {
                self.upcomingTableView.reloadData()
            }
        }
        
        viewModel.reloadPopularTableView = {
            DispatchQueue.main.async {
                self.popularTableView.reloadData()
            }
        }
        
        viewModel.showError = {
            DispatchQueue.main.async {
                self.showErrorPopUp(errorMsg: self.viewModel.errorMsg)
            }
        }
        
        viewModel.startLoading = {
            DispatchQueue.main.async {
                self.showSpinner()
            }
        }
        
        viewModel.stopLoading = {
            DispatchQueue.main.async {
                self.removeSpinner()
            }
        }
        
        viewModel.getMovieList()
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == upcomingTableView ? viewModel.upcomingMoviesList.count : viewModel.popularMoviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.selectionStyle = .none
        if tableView == upcomingTableView {
            cell.render(id: viewModel.upcomingMoviesList[indexPath.row].id ?? 0, imgUrl: viewModel.upcomingMoviesList[indexPath.row].posterPath ?? "", movieTitle: viewModel.upcomingMoviesList[indexPath.row].title ?? "", releasedDate: viewModel.upcomingMoviesList[indexPath.row].releaseDate ?? "")
        } else {
            cell.render(id: viewModel.popularMoviesList[indexPath.row].id ?? 0, imgUrl: viewModel.popularMoviesList[indexPath.row].posterPath ?? "", movieTitle: viewModel.popularMoviesList[indexPath.row].title ?? "", releasedDate: viewModel.popularMoviesList[indexPath.row].releaseDate ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == upcomingTableView {
            viewModel.goToDetails(id: String(viewModel.upcomingMoviesList[indexPath.row].id ?? 0))
        } else {
            viewModel.goToDetails(id: String(viewModel.popularMoviesList[indexPath.row].id ?? 0))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}
