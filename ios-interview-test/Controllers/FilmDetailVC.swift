//
//  FilmDetailVC.swift
//  ios-interview-test
//

import UIKit

class FilmDetailVC : UIViewController, ViewControllerSetup {
    
    // MARK: - Properties
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let imageView: UIImageView = UIImageView()
    private var venue: Venue? = nil
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        appDelegate.filmDetailPresenter.fetchImage { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                self.appDelegate.errorPresenter.message = error?.localizedDescription ?? "no error"
                self.appDelegate.errorPresenter.present(in: self)
            }
        }
        
        appDelegate.filmDetailPresenter.fetchVenue { (venue, error) in
            if venue != nil {
                self.venue = venue
            } else {
                self.appDelegate.errorPresenter.message = error?.localizedDescription ?? "no error"
                self.appDelegate.errorPresenter.present(in: self)
            }
        }
    }
    
    // MARK: - ViewControllerSetup protocol
    
    func setupUI() {
        
        title = appDelegate.filmDetailPresenter.film!.name
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
        guard self.venue != nil else {
            appDelegate.errorPresenter.message = "No venue associated with the movie"
            appDelegate.errorPresenter.present(in: self)
            return
        }
        appDelegate.venueDetailPresenter.venue = self.venue
        let venueDetailVC = VenueDetailVC()
        self.navigationController?.pushViewController(venueDetailVC, animated: true)
    }

}
