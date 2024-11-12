//
//  MovieDetailsViewModel.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import RealmSwift

class MovieDetailsViewModel: ObservableObject {
    var title: String
    var releasedDate: String
    var overview: String
    var image: Data
    
    init(id: String) {
        let realm = try! Realm()
        let movies = realm.objects(Movies.self).filter("id == %@", id)
        let movie = movies.first
        
        title = movie?.title ?? ""
        releasedDate = movie?.releasedDate ?? ""
        overview = movie?.overview ?? ""
        image = movie?.image ?? Data()
    }
}
