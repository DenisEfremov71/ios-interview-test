//
//  FilmDetailPresenter.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-28.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import UIKit

enum FilmDetailPresenterError: Error {
    case invalidImageData
    case forwarded(Error)
}

class FilmDetailPresenter {
    
    let film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    func fetchImage(completion: @escaping (UIImage?, FilmDetailPresenterError?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let imageUrl = self.film.thumbnailUrl
            var imageData: NSData
            do {
                imageData = try NSData(contentsOf: imageUrl)
                if let image = UIImage(data: imageData as Data) {
                    completion(image, nil)
                } else {
                    completion(nil, .invalidImageData)
                }
            } catch let error {
                completion(nil, .forwarded(error))
            }
        }
    }
    
    func fetchVenue(completion: @escaping (Venue?, Error?) -> Void) {
        Venue.getVenue(uid: film.venueId) { (result) in
            switch result {
            case .success(let venueObject):
                completion(venueObject, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
