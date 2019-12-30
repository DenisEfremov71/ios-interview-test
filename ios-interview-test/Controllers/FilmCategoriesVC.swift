//
//  FilmCategoriesVC.swift
//  ios-interview-test
//

import UIKit

class FilmCategoriesVC : UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewSetup, ViewControllerSetup {
    var tableView = UITableView()
    
    
    // MARK: - Properties
    
    var cellId = "categoryCell"
    let categoryPresenter: CategoryPresenter!
    var errorPresenter: ErrorPresenter!
    
    // MARK: - Initializers
    
    init(with presenter: CategoryPresenter, errorPresenter: ErrorPresenter) {
        self.categoryPresenter = presenter
        self.errorPresenter = errorPresenter
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
    }
}
