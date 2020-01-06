//
//  MockExtensions.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-04.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import Foundation
import UIKit
@testable import ios_interview_test

extension FilmsVCTests {
    
    class FilmVCTableViewMock: UITableView {
        var cellDequeuedProperly = false
        
        class func initMock(dataSource: FilmsVC) -> FilmVCTableViewMock {
            let mock = FilmVCTableViewMock(frame: CGRect(x: 0, y: 0, width: 300, height: 500), style: .plain)
            mock.dataSource = dataSource
            mock.register(FilmCellMock.self, forCellReuseIdentifier: dataSource.cellId)
            return mock
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellDequeuedProperly = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class FilmCellMock: FilmCell {
        var filmData: Film?
        
        override func update(film: Film) {
            filmData = film
        }
    }
    
}

extension FilmFetchingTests {
    
    class FilmPresenterMockup: FilmPresenter {
        
        var endpoint = String()
        
        override func getFilms(category: Int, completion: @escaping (Bool, Error?) -> Void) {
            
            guard !endpoint.isEmpty else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Endpoint is empty."]) as Error
                completion(false, error)
                return
            }
            
            guard let url:URL = URL.init(string: self.endpoint) else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to create URL from string: \(self.endpoint)"]) as Error
                completion(false, error)
                return
            }
            
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
    
}

extension VenueFetchingTests {
    
    class FilmDetailPresenterMockup: FilmDetailPresenter {
        
        var endpoint = String()
        
        override func fetchVenue(completion: @escaping (Venue?, Error?) -> Void) {
            
            guard !endpoint.isEmpty else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Endpoint is empty."]) as Error
                completion(nil, error)
                return
            }
            
            guard let url:URL = URL.init(string: self.endpoint) else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to create URL from string: \(self.endpoint)"]) as Error
                completion(nil, error)
                return
            }
            
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
    
}

extension FilmPresenterTests {
    
    class FilmPresenterMockup: FilmPresenter {
        
        var resourceName = String()
        
        override func getFilms(category: Int, completion: @escaping (Bool, Error?) -> Void) {
            
            let testBundle = Bundle(for: type(of: self))
            guard let fileURL = testBundle.url(forResource: resourceName, withExtension: "json") else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not find movielist.json file."]) as Error
                completion(false, error)
                return
            }
            
            let data = try? Data(contentsOf: fileURL)
            
            guard data != nil else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not convert movielist.json file to data."]) as Error
                completion(false, error)
                return
            }
            
            do {
                let films = try JSONDecoder().decode([Film].self, from: data!)
                self.films = films.filter { $0.categoryId.contains(category) }
                completion(true, nil)
            } catch {
                completion(false, error)
            }
            
        }
        
    }
}

extension FilmDetailPresenterTests {
    
    class FilmDetailPresenterMockup: FilmDetailPresenter {
        
        override func fetchVenue(completion: @escaping (Venue?, Error?) -> Void) {
            
            let testBundle = Bundle(for: type(of: self))
            guard let fileURL = testBundle.url(forResource: "venuelist", withExtension: "json") else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not find venuelist.json file."]) as Error
                completion(nil, error)
                return
            }
            
            let data = try? Data(contentsOf: fileURL)
            
            guard data != nil else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not convert venuelist.json file to data."]) as Error
                completion(nil, error)
                return
            }
            
            do {
                let venues = try JSONDecoder().decode([Venue].self, from: data!)
                let venuesFiltered = venues.filter { $0.uid == self.film?.venueId }
                completion(venuesFiltered.first, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
