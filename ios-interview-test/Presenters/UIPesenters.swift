//
//  UIPesenters.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-29.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import UIKit

struct ErrorPresenter {
 
    var message: String
    
    func present(in viewController: UIViewController) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
