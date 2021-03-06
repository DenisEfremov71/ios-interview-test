//
//  FilmCategoriesVC-UITableViewDelegate.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-28.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import UIKit

extension FilmCategoriesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filmsVC = FilmsVC.init(category: appDelegate.categoryPresenter.categories[indexPath.row]) else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(filmsVC, animated: true)
    }
    
}
