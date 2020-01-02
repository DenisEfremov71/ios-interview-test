//
//  FilmPresenter.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-28.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import UIKit

class FilmPresenter: ImageCaching {

    var films = [Film]()
    var filmCache = NSCache<NSString, UIImage>()
    
    func getFilms(category: Int, completion: @escaping (Bool, Error?) -> Void) {
                
        Film.getFilms(category: category) { (result) in
            switch result {
            case .success(let filmObjects):
                self.films = filmObjects
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
        
    }
    
}
