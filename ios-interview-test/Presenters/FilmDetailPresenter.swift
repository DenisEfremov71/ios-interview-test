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

class FilmDetailPresenter: ImageCaching {
    
    var film: Film?
    var filmCache = NSCache<NSString, UIImage>()
    
    init(film: Film? = nil) {
        self.film = film
    }
    
    func fetchImage(completion: @escaping (UIImage?, FilmDetailPresenterError?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let imageUrl = self.film!.thumbnailUrl
            var imageData: NSData
            do {
                if let cachedImage = self.getFilmImageFromCache(for: self.film!.thumbnailUrl.absoluteString as NSString) {
                    completion(cachedImage, nil)
                } else {
                    imageData = try NSData(contentsOf: imageUrl)
                    if let image = UIImage(data: imageData as Data) {
                        self.film!.image = image
                        self.storeImageInCache(for: self.film!)
                        completion(image, nil)
                    } else {
                        completion(nil, .invalidImageData)
                    }
                }
            } catch let error {
                completion(nil, .forwarded(error))
            }
        }
    }
    
    func fetchVenue(completion: @escaping (Venue?, Error?) -> Void) {
        
        guard let url:URL = URL.init(string: EndPoints.venueUrlString) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to create URL from string: \(EndPoints.venueUrlString)"]) as Error
            completion(nil, error)
            return
        }
        
        /*
         Example response:
         [{ "uid": 1, "name": "AMC Kabuki", "address": "1881 Post St, San Francisco, CA 94115" }]
         */
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion(nil, error)
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let venues = try decoder.decode([Venue].self, from: jsonData)
                    guard let venue = venues.first(where: { $0.uid == self.film!.venueId } ) else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to find the venue for the film \(self.film?.name ?? "no name")"]) as Error
                        completion(nil, error)
                        return
                    }
                    completion(venue, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
}
