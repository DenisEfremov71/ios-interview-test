//
//  Caching.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2020-01-02.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCaching {
    var filmCache: NSCache<NSString, UIImage> { get }
    func getFilmImageFromCache(for key: NSString) -> UIImage?
    func storeImageInCache(for film: Film)
}

extension ImageCaching {
    func getFilmImageFromCache(for key: NSString) -> UIImage? {
        return filmCache.object(forKey: key)
    }
    func storeImageInCache(for film: Film) {
        filmCache.setObject(film.image!, forKey: film.thumbnailUrl.absoluteString as NSString)
    }
}
