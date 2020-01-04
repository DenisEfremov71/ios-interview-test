//
//  VenueDetailVCTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class VenueDetailVCTests: XCTestCase {
    
    var sut: VenueDetailVC!

    override func setUp() {
        super.setUp()
        sut = VenueDetailVC()
        sut.appDelegate.venueDetailPresenter.venue = Venue(uid: 1, name: "AMC Kabuki", address: "1881 Post St, San Francisco, CA 94115")
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInit_WhenInitialized_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }

}
