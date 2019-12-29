//
//  FilmsVC.swift
//  ios-interview-test
//
//

import UIKit

class FilmsVC : UIViewController, UITableViewDelegate, UITableViewDataSource, ViewControllerSetup {

    // MARK: - Properties
    
    let cellId = "filmCell"
    let tableView: UITableView = UITableView()
    private let filmCategory: FilmCategory
    let filmPresenter = FilmPresenter()
    
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
        
        filmPresenter.getFilms(category: filmCategory.uid) { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                if let error = error {
                    fatalError("error: \(error.localizedDescription)")
                } else {
                    print("Unknown error getting the films")
                }
            }
        }
    }
    
    // MARK: - Methods
    
    func setupTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = view.frame.width
        let displayHeight: CGFloat = view.frame.height
        
        tableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        tableView.separatorColor = .lightGray
        tableView.register(FilmCell.self, forCellReuseIdentifier: cellId)
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
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

