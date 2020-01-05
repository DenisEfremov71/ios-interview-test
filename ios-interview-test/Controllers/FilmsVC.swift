//
//  FilmsVC.swift
//  ios-interview-test
//
//

import UIKit

class FilmsVC: UIViewController, TableViewSetup, ViewControllerSetup {

    // MARK: - Properties
    
    var cellId = "filmCell"
    var tableView = UITableView()
    private let filmCategory: FilmCategory
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let pendingOperations = PendingOperations()
    var currentFilmCategory: FilmCategory {
        return filmCategory
    }
    
    // MARK: - Initializers
    
    init? (category: FilmCategory) {
        self.filmCategory = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        appDelegate.filmPresenter.getFilms(category: filmCategory.uid) { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                if let error = error {
                    self.appDelegate.errorPresenter.message = error.localizedDescription
                } else {
                    self.appDelegate.errorPresenter.message = "Unknown error getting the films"
                }
                self.appDelegate.errorPresenter.present(in: self)
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
        applyConstraints()
    }
    
}

