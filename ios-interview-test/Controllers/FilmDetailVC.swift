//
//  FilmDetailVC.swift
//  ios-interview-test
//

import UIKit

class FilmDetailVC : UIViewController {
    
    // MARK: - Subviews
    
    var imageView: UIImageView = UIImageView()
    var venueButton = UIButton()
    
    // MARK: - Properties
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var venue: Venue? = nil
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        venueButton.isHidden = true
        imageView.isHidden = true
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
