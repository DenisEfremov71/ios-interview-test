//
//  FilmCategoriesVC.swift
//  ios-interview-test
//

import UIKit

protocol ViewControllerSetup {
    func setupUI()
}

class FilmCategoriesVC : UIViewController, UITableViewDelegate, UITableViewDataSource, ViewControllerSetup {
    
    // MARK: - Properties
    
    let cellId = "categoryCell"
    let tableView: UITableView = UITableView()
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
    
    // MARK: - Methods
    
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
    
    // MARK: - ViewControllerSetup protocol
    
    func setupUI() {
        title = "Film Categories"
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        setupTableView()
    }
}
