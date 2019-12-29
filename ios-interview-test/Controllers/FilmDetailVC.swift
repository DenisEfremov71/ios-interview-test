//
//  FilmDetailVC.swift
//  ios-interview-test
//

import UIKit

class FilmDetailVC : UIViewController, ViewControllerSetup {
    
    // MARK: - Properties
    
    let filmDetailPresenter: FilmDetailPresenter!
    var errorPresenter: ErrorPresenter!
    private let imageView: UIImageView = UIImageView()
    private var venue: Venue? = nil
    
    // MARK: - Initializers
    
    init? (filmDetailPresenter: FilmDetailPresenter, errorPresenter: ErrorPresenter) {
        self.filmDetailPresenter = filmDetailPresenter
        self.errorPresenter = errorPresenter
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
                self.errorPresenter.message = error?.localizedDescription ?? "no error"
                self.errorPresenter.present(in: self)
            }
        }
        
        self.filmDetailPresenter.fetchVenue { (venue, error) in
            if venue != nil {
                self.venue = venue
            } else {
                self.errorPresenter.message = error?.localizedDescription ?? "no error"
                self.errorPresenter.present(in: self)
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
        venueButton.addTarget(self, action: #selector(onVenueButton), for: .touchUpInside)
        view.addSubview(venueButton)
        
    }
    
    // MARK: - Actions
    
    @objc func onVenueButton(sender: UIButton!) {
        errorPresenter.message = "The feature is not implemented yet!"
        errorPresenter.present(in: self)
    }

}
