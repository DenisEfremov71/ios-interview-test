//
//  VenueDetailVC.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-30.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import UIKit
import MapKit

class VenueDetailVC: UIViewController {
    
    // MARK: - Subviews
    
    var venueAddress = UILabel()
    var mapView = MKMapView()
    
    // MARK: - Properties
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
    }

}
