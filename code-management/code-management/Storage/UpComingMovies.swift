//
//  UpComingMovies.swift
//  code-management
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import RealmSwift

class UpComingMovies: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var releasedDate = ""
    @objc dynamic var isFavorite = false
    @objc dynamic var overview = ""
    @objc dynamic var imagePath = ""
}
