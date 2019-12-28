//
//  FilmDetailPresenter.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-28.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import UIKit

class FilmDetailPresenter {
    
    let film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    func fetchImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            let imageUrl = self.film.thumbnailUrl
            var imageData: NSData
            do {
                imageData = try NSData(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.imageView.image = image
                    self.imageView.contentMode = UIViewContentMode.scaleAspectFit
                }
            } catch {
                print("Error downloading image")
            }
        }
    }
    
    func fetchVenue() {
        
    }
    
}
