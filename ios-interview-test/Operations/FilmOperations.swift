//
//  FilmOperations.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-28.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import UIKit

class PendingOperations {
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1   // comment out to allow the queue to decide how many operations it can handle at once
        return queue
    }()
}

class ImageDownloader: Operation {

    var film: Film
    
    init(_ film: Film) {
        self.film = film
    }
    
    override func main() {

        if isCancelled {
            return
        }
        
        guard let imageData = try? Data(contentsOf: film.thumbnailUrl) else { return }
        
        if isCancelled {
            return
        }
        
        if !imageData.isEmpty {
            film.image = UIImage(data:imageData)
            film.state = .downloaded
        } else {
            film.state = .failed
            film.image = UIImage(named: "Failed")
        }
    }
}
