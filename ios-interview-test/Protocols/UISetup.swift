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
    func addViews()
    func layoutViews()
}

extension ViewControllerSetup {
    func addViews() {}
    func layoutViews() {}
}

protocol TableViewSetup {
    var cellId: String { get set }
    var tableView: UITableView { get set }
    func setupTableView()
    func applyConstraints()
}

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
    
    func applyConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // tableView.top = view.top
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)]
        // tableView.leading = view.leading
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        // tableView.trailing = view.trailing
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)]
        // tableView.bottom = view.bottom
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)]
        
        self.view.addConstraints(constraints)
    }
    
}
