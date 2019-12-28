//
//  FilmsVC.swift
//  ios-interview-test
//
//

import UIKit

class FilmsVC : UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let cellId = "filmCell"
    private let tableView: UITableView = UITableView()
    private let filmCategory: FilmCategory
    
    private var films: [Film] = []
    
    init? (category: FilmCategory) {
        self.filmCategory = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = filmCategory.category.rawValue
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        setupTableView()
        
        Film.getFilms(category: filmCategory.uid) { (result) in
            switch result {
            case .success(let filmObjects):
                self.films = filmObjects
                self.tableView.reloadData()
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FilmCell
        
        let film = films[indexPath.row]
        cell.update(film: film)
        cell.textLabel?.text = film.name
        let imageUrl = film.thumbnailUrl
        do {
            let imageData:NSData = try NSData(contentsOf: imageUrl)
            let image = UIImage(data: imageData as Data)
            cell.imageView?.image = image
            cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        } catch {
            print("Error downloading image")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filmDetailVC = FilmDetailVC.init(film: films[indexPath.row]) else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(filmDetailVC, animated: true)
    }
}

