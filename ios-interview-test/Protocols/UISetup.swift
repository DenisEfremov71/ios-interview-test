//
//  UISetup.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-30.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import UIKit

protocol ViewControllerSetup {
    func setupUI()
}

protocol TableViewSetup {
    var cellId: String { get set }
    var tableView: UITableView { get set }
    func setupTableView()
}
