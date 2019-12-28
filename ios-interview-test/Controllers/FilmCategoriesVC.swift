//
//  FilmCategoriesVC.swift
//  ios-interview-test
//

import UIKit

class FilmCategoriesVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "categoryCell"
    let tableView: UITableView = UITableView()
    let categoryPresenter = CategoryPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Film Categories"
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        setupTableView()
    }
    
    func setupTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = view.frame.width
        let displayHeight: CGFloat = view.frame.height
        
        tableView.frame = CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - barHeight)
        tableView.separatorColor = .lightGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
}
