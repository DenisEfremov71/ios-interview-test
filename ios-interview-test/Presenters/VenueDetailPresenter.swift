//
//  VenuePresenter.swift
//  ios-interview-test
//
//  Created by Denis Efremov on 2019-12-30.
//  Copyright © 2019 Eventbase. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

enum VenueDetailPresenterError: Error {
    case noVenue
    case noPlacemarks
    case forwarded(Error)
}

class VenueDetailPresenter {
    
    var venue: Venue?
    let geoCoder = CLGeocoder()
    
    init(venue: Venue? = nil) {
        self.venue = venue
    }
    
    func getPlacemark(completion: @escaping (MKPlacemark?, VenueDetailPresenterError?) -> Void) {
        guard self.venue != nil else {
            completion(nil, .noVenue)
            return
        }
        DispatchQueue.global(qos: .background).async {
            self.geoCoder.geocodeAddressString(self.venue!.address) { (placemarks, error) in
                guard error == nil else {
                    completion(nil, .forwarded(error!))
                    return
                }
                guard let placemarks = placemarks else {
                    completion(nil, .noPlacemarks)
                    return
                }
                let placemark = MKPlacemark(placemark: placemarks.first!)
                completion(placemark, nil)
            }
        }
    }
    
}
