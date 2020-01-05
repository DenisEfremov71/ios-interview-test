//
//  VenueDetailPresenterTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class VenueDetailPresenterTests: XCTestCase {

    var sut: VenueDetailPresenter!
    let venue = Venue(uid: 1, name: "AMC Kabuki", address: "1881 Post St, San Francisco, CA 94115")
    
    override func setUp() {
        super.setUp()
        sut = VenueDetailPresenter(venue: venue)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Initialization
    
    func testInit_WhenInitialized_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInit_WhenInitialized_GeoCoderShouldNotBeNil() {
        XCTAssertNotNil(sut.geoCoder)
    }
    
    func testInit_WhenInitializedWithVenue_VenueShouldBeSet() {
        XCTAssertEqual(sut.venue, venue)
    }

}
