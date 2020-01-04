//
//  VenueTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class VenueTests: XCTestCase {
    
    var sut: Venue!

    override func setUp() {
        super.setUp()
        sut = Venue(uid: 1, name: "AMC Kabuki", address: "1881 Post St, San Francisco, CA 94115")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInit_WhenInitialized_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInit_WhenGivenValues_TakesValues() {
        XCTAssertEqual(sut.uid, 1)
        XCTAssertEqual(sut.name, "AMC Kabuki")
        XCTAssertEqual(sut.address, "1881 Post St, San Francisco, CA 94115")
    }

}
