//
//  FilmDetailVC.swift
//  ios-interview-test
//

import UIKit

class FilmDetailVC : UIViewController {
    
    private let imageView: UIImageView = UIImageView()
    private let film: Film
    
    private var venue: Venue? = nil
    
    init? (film: Film) {
        self.film = film
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = film.name
        self.view.backgroundColor = .white

        let displayWidth: CGFloat = view.frame.width
        
        imageView.frame.size = CGSize(width: 200, height: 350)
        imageView.frame.origin = CGPoint(x: displayWidth/2-imageView.frame.size.width/2, y: 50)
        view.addSubview(imageView)
        self.fetchImage()
        
        let venueButton = UIButton()
        venueButton.frame.size = CGSize(width: imageView.frame.size.width, height: 50)
        venueButton.frame.origin = CGPoint(x: displayWidth/2-venueButton.frame.size.width/2, y: imageView.frame.size.height + venueButton.frame.size.height)
        venueButton.setTitle("Venue", for: .normal)
        venueButton.setTitleColor(.black, for: .normal)
        venueButton.layer.borderColor = UIColor.black.cgColor
        venueButton.layer.borderWidth = 1
        view.addSubview(venueButton)
        
        self.fetchVenue()
    }
    
    func fetchImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            let imageUrl = self.film.thumbnailUrl
            var imageData: NSData
            do {
                imageData = try NSData(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.imageView.image = image
                    self.imageView.contentMode = UIViewContentMode.scaleAspectFit
                }
            } catch {
                print("Error downloading image")
            }
        }
    }
    
    func fetchVenue() {
        Venue.getVenue(uid: film.venueId) { (result) in
            switch result {
            case .success(let venueObject):
                self.venue = venueObject
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
}
