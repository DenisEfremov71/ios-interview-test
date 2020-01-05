//
//  FilmCategoriesVC.swift
//  ios-interview-test
//

import UIKit

class FilmCategoriesVC : UIViewController, TableViewSetup, ViewControllerSetup {
    
    // MARK: - Properties
    
    var cellId = "categoryCell"
    var tableView = UITableView()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - ViewControllerSetup protocol
    
    func setupUI() {
        title = "Film Categories"
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        setupTableView()
        applyConstraints()
    }
}
