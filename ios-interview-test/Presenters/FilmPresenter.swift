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
        
        guard let url:URL = URL.init(string: EndPoints.movieUrlString) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to create URL from string: \(EndPoints.movieUrlString)"]) as Error
            completion(false, error)
            return
        }
        
        /*
         Example response:
         [{ "uid": 1, "name": "Avengers: Infinity War", "shortDesc": "Lorem Ipsum", "duration": 120, "thumbnailUrl": "https://s3.amazonaws.com/mobile.scribd.com/ios-interview-test/avg.jpg", "category": 1, "venue": 1 }]
         */
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion(false, error)
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let films = try decoder.decode([Film].self, from: jsonData)
                    self.films = films.filter { $0.categoryId.contains(category) }
                    completion(true, nil)
                } catch {
                    completion(false, error)
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                completion(false, error)
            }
        }
        task.resume()
    }
    
}
