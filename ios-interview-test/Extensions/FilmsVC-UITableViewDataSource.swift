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
        
        let film = filmPresenter.films[indexPath.row]
        cell.update(film: film)
        cell.textLabel?.text = film.name
        let imageUrl = film.thumbnailUrl
        do {
            let imageData:NSData = try NSData(contentsOf: imageUrl)
            let image = UIImage(data: imageData as Data)
            cell.imageView?.image = image
            cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        } catch {
            print("Error downloading image")
        }
        
        return cell
    }
    
}
