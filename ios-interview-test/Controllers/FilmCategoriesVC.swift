//
//  FilmCategoriesVC.swift
//  ios-interview-test
//

import UIKit

class FilmCategoriesVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellId = "categoryCell"
    private let categories: [FilmCategory] = FilmCategory.allCategories()
    private let tableView: UITableView = UITableView()
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].category.rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filmVC = FilmsVC.init(category: categories[indexPath.row]) else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(filmVC, animated: true)
    }
}
