//
//  VenueDetailVC.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-30.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import UIKit

class VenueDetailVC: UIViewController, ViewControllerSetup {
    
    // MARK: - Properties
    
    let venueDetailPresenter: VenueDetailPresenter!
    var errorPresenter: ErrorPresenter!    
    
    // MARK: - Initializers
    
    init? (venueDetailPresenter: VenueDetailPresenter, errorPresenter: ErrorPresenter) {
        self.venueDetailPresenter = venueDetailPresenter
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
    }
    
    // MARK: - ViewControllerSetup protocol
    
    func setupUI() {
        title = "Venue: \(venueDetailPresenter.venue.name)"
        view.backgroundColor = .white
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        let venueAddress = UILabel(frame: CGRect(x: 20, y: 20, width: 280, height: 100))
        venueAddress.center = CGPoint(x: 160, y: 100)
        venueAddress.textAlignment = .left
        venueAddress.text = "Address: \(venueDetailPresenter.venue.address)"
        venueAddress.numberOfLines = 2
        venueAddress.lineBreakMode = .byWordWrapping
        self.view.addSubview(venueAddress)
        
    }

}
