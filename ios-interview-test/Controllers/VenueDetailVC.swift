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
        
    }

}
