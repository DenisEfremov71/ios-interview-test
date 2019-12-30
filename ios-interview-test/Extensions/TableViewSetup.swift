//
//  TableViewSetup.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-30.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import UIKit

extension TableViewSetup where Self: UIViewController, Self: UITableViewDataSource, Self: UITableViewDelegate {
    
    var cellClass: AnyClass {
        return cellId == "filmCell" ? FilmCell.self : UITableViewCell.self
    }
    
    func setupTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = view.frame.width
        let displayHeight: CGFloat = view.frame.height
        
        tableView.frame = CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - barHeight)
        tableView.separatorColor = .lightGray
        tableView.register(cellClass, forCellReuseIdentifier: cellId)
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
}
