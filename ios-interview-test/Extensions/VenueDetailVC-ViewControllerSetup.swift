//
//  VenueDetailVC-ViewControllerSetup.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2020-01-02.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import Foundation
import MapKit
import UIKit

extension VenueDetailVC: ViewControllerSetup {
    
    func setupUI() {
        title = "Venue: \(appDelegate.venueDetailPresenter.venue!.name)"
        view.backgroundColor = .white
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        addViews()
        layoutViews()
    }
    
    func addViews() {
        addVenueAddressLabel()
        addMapView()
    }
    
    func layoutViews() {
        var constraints = [NSLayoutConstraint]()
        
        venueAddress.translatesAutoresizingMaskIntoConstraints = false
        // venueAddress.top = view.safeAreaLayoutGuide.top + 10
        constraints += [NSLayoutConstraint.init(item: venueAddress, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 10.0)]
        // venueAddress.leading = view.leading + 20
        constraints += [NSLayoutConstraint.init(item: venueAddress, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 20.0)]
        // venueAddress.trailing = view.trailing - 20
        constraints += [NSLayoutConstraint.init(item: venueAddress, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -20.0)]
        // venueAddress.height = 50
        constraints += [NSLayoutConstraint.init(item: venueAddress, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)]
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        // mapView.top = venueAddress.bottom
        constraints += [NSLayoutConstraint.init(item: mapView, attribute: .top, relatedBy: .equal, toItem: venueAddress, attribute: .bottom, multiplier: 1.0, constant: 0.0)]
        // mapView.leading = view.leading
        constraints += [NSLayoutConstraint.init(item: mapView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        // mapView.trailing = view.trailing
        constraints += [NSLayoutConstraint.init(item: mapView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)]
        // mapView.bottom = view.bottom
        constraints += [NSLayoutConstraint.init(item: mapView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)]
        
        view.addConstraints(constraints)
    }
    
    func addVenueAddressLabel() {
        venueAddress.textAlignment = .left
        venueAddress.text = "Address: \(appDelegate.venueDetailPresenter.venue!.address)"
        venueAddress.numberOfLines = 2
        venueAddress.lineBreakMode = .byWordWrapping
        self.view.addSubview(venueAddress)
    }
    
    func addMapView() {
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        appDelegate.venueDetailPresenter.getPlacemark { (placemark, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.appDelegate.errorPresenter.message = error!.localizedDescription
                    self.appDelegate.errorPresenter.present(in: self)
                }
                return
            }
            guard placemark != nil else {
                DispatchQueue.main.async {
                    self.appDelegate.errorPresenter.message = "No placemark found for the address."
                    self.appDelegate.errorPresenter.present(in: self)
                }
                return
            }
            let region = MKCoordinateRegionMakeWithDistance(placemark!.coordinate, CLLocationDistance(exactly: 500)!, CLLocationDistance(exactly: 500)!)
            DispatchQueue.main.async {
                self.mapView.addAnnotation(placemark!)
                self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
            }
        }
        
        self.view.addSubview(mapView)
    }
    
}
