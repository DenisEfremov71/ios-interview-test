//
//  FilmDetailVC-ViewControllerSetup.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import Foundation
import UIKit

extension FilmDetailVC: ViewControllerSetup {
    
    func setupUI() {
        
        title = appDelegate.filmDetailPresenter.film!.name
        self.view.backgroundColor = .white
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        addViews()
        layoutViews()
        
    }
    
    func addViews() {
        addImageView()
        addVenueButton()
    }
    
    func layoutViews() {
        var constraints = [NSLayoutConstraint]()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // imageView.top = view.safeAreaLayoutGuide.top + 10
        constraints += [NSLayoutConstraint.init(item: imageView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 10.0)]
        // imageView.centerX = view.centerX
        constraints += [NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)]
        // imageView.width <= 200
        constraints += [NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0)]
        // imageView.height <= 350
        constraints += [NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 350.0)]
        
        venueButton.translatesAutoresizingMaskIntoConstraints = false
        // venueButton.top = imageView.bottom + 10
        constraints += [NSLayoutConstraint.init(item: venueButton, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 10.0)]
        // venueButton.centerX = view.centerX
        constraints += [NSLayoutConstraint.init(item: venueButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)]
        // venueButton.width = imageView.width
        constraints += [NSLayoutConstraint.init(item: venueButton, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1.0, constant: 0.0)]
        // venueButton.height = 50
        constraints += [NSLayoutConstraint.init(item: venueButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)]
        // venueButton.bottom <= view.bottom - 10
        constraints += [NSLayoutConstraint.init(item: venueButton, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -10.0)]
        
        view.addConstraints(constraints)
        imageView.isHidden = false
        venueButton.isHidden = false
    }
    
    func addImageView() {
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(imageView)
    }
    
    func addVenueButton() {
        venueButton.setTitle("Venue", for: .normal)
        venueButton.setTitleColor(.black, for: .normal)
        venueButton.layer.borderColor = UIColor.black.cgColor
        venueButton.layer.borderWidth = 1
        venueButton.addTarget(self, action: #selector(onVenueButton), for: .touchUpInside)
        view.addSubview(venueButton)
    }
    
}
