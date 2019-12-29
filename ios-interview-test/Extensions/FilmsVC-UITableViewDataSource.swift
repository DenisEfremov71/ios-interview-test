//
//  FilmsVC-UITableViewDataSource.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-28.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import UIKit

extension FilmsVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmPresenter.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FilmCell
        
        if cell.accessoryView == nil {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            cell.accessoryView = indicator
        }
        let indicator = cell.accessoryView as! UIActivityIndicatorView
        
        let film = filmPresenter.films[indexPath.row]
        cell.update(film: film)
        cell.textLabel?.text = film.name
        cell.imageView?.image = film.image
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        switch (film.state) {
        
        case .failed:
            indicator.stopAnimating()
            cell.textLabel?.text = "Failed to load"
        case .new:
            indicator.startAnimating()
            if !tableView.isDragging && !tableView.isDecelerating {
                startOperations(for: film, at: indexPath)
            }
        case .downloaded:
            indicator.stopAnimating()
        }
        
        return cell
    }
    
    // MARK: - operation management
    
    func startOperations(for film: Film, at indexPath: IndexPath) {
        switch (film.state) {
        case .new:
            startDownload(for: film, at: indexPath)
        case .downloaded:
            NSLog("Film has been downloaded")
        case .failed:
            NSLog("Film failed to download")
        }
    }
    
    func startDownload(for film: Film, at indexPath: IndexPath) {
        
        guard pendingOperations.downloadsInProgress[indexPath] == nil else {
            return
        }
        
        let downloader = ImageDownloader(film)
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            self.filmPresenter.films[indexPath.row].image = downloader.film.image
            self.filmPresenter.films[indexPath.row].state = FilmImageState.downloaded
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
}
