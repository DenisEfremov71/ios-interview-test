//
//  FilmDetailVC.swift
//  ios-interview-test
//

import UIKit

class FilmDetailVC : UIViewController, ViewControllerSetup {
    
    // MARK: - Properties
    
    let filmDetailPresenter: FilmDetailPresenter!
    private let imageView: UIImageView = UIImageView()
    private var venue: Venue? = nil
    
    // MARK: - Initializers
    
    init? (filmDetailPresenter: FilmDetailPresenter) {
        self.filmDetailPresenter = filmDetailPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        
        setupUI()
        
        self.filmDetailPresenter.fetchImage { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                print(error?.localizedDescription ?? "no error")
            }
        }
        
        self.filmDetailPresenter.fetchVenue { (venue, error) in
            if venue != nil {
                self.venue = venue
            } else {
                print(error?.localizedDescription ?? "no error")
            }
        }
    }
    
    // MARK: - ViewControllerSetup protocol
    
    func setupUI() {
        
        title = filmDetailPresenter.film.name
        self.view.backgroundColor = .white
        
        let displayWidth: CGFloat = view.frame.width
        
        imageView.frame.size = CGSize(width: 200, height: 350)
        imageView.frame.origin = CGPoint(x: displayWidth/2-imageView.frame.size.width/2, y: 50)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(imageView)
        
        let venueButton = UIButton()
        venueButton.frame.size = CGSize(width: imageView.frame.size.width, height: 50)
        venueButton.frame.origin = CGPoint(x: displayWidth/2-venueButton.frame.size.width/2, y: imageView.frame.size.height + venueButton.frame.size.height)
        venueButton.setTitle("Venue", for: .normal)
        venueButton.setTitleColor(.black, for: .normal)
        venueButton.layer.borderColor = UIColor.black.cgColor
        venueButton.layer.borderWidth = 1
        view.addSubview(venueButton)
        
    }

}
