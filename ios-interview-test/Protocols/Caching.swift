//
//  Caching.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2020-01-02.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import Foundation
import UIKit

class FilmImage: NSDiscardableContent {
    
    var image: UIImage?
    
    func beginContentAccess() -> Bool {
        return true
    }
    
    func endContentAccess() {
    }
    
    func discardContentIfPossible() {
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
}

protocol ImageCaching {
    var filmCache: NSCache<NSString, FilmImage> { get }
    func getFilmImageFromCache(for key: NSString) -> FilmImage?
    func storeImageInCache(for film: Film)
}

extension ImageCaching {
    func getFilmImageFromCache(for key: NSString) -> FilmImage? {
        return filmCache.object(forKey: key)
    }
    func storeImageInCache(for film: Film) {
        let filmImage = FilmImage()
        filmImage.image = film.image
        filmCache.setObject(filmImage, forKey: film.thumbnailUrl.absoluteString as NSString)
    }
}
