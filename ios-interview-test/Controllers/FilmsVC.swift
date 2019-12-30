//
//  FilmsVC.swift
//  ios-interview-test
//
//

import UIKit

class FilmsVC : UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewSetup, ViewControllerSetup {

    // MARK: - Properties
    
    var cellId = "filmCell"
    var tableView = UITableView()
    private let filmCategory: FilmCategory
    var errorPresenter: ErrorPresenter!
    let filmPresenter: FilmPresenter!
    let pendingOperations = PendingOperations()
    
    // MARK: - Initializers
    
    init? (category: FilmCategory, presenter: FilmPresenter, errorPresenter: ErrorPresenter) {
        self.filmCategory = category
        self.filmPresenter = presenter
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
        
        filmPresenter.getFilms(category: filmCategory.uid) { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                if let error = error {
                    self.errorPresenter.message = error.localizedDescription
                } else {
                    self.errorPresenter.message = "Unknown error getting the films"
                }
                self.errorPresenter.present(in: self)
            }
        }
    }
    
    // MARK: - ViewControllerSetup protocol
    
    func setupUI() {
        title = filmCategory.category.rawValue
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        setupTableView()
    }
    
}

