//
//  UIImageViewEx.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit
import RealmSwift

extension UIImageView {
    func loadImg(from url: URL, id: String) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                let realm = try! Realm()
                let movies = realm.objects(Movies.self).filter("id == %@", id)
                let movie: Movies? = movies.first
                
                do {
                    try realm.write {
                        movie?.image = data
                    }
                } catch {
                    print(error)
                }
                
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
        
    }
}
