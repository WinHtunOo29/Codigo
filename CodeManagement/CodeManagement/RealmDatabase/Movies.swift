//
//  Movies.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import RealmSwift

class Movies: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var releasedDate = ""
    @objc dynamic var isFavourite = false
    @objc dynamic var isPopular = false
    @objc dynamic var overview = ""
    @objc dynamic var image = Data()
}
