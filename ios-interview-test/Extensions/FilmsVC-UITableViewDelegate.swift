//
//  FilmsVC-UITableViewDelegate.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-28.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import UIKit

extension FilmsVC {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filmDetailVC = FilmDetailVC(filmDetailPresenter: FilmDetailPresenter(film: filmPresenter.films[indexPath.row]), errorPresenter: errorPresenter) else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(filmDetailVC, animated: true)
    }
    
}
