//
//  FilmsVCTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class FilmsVCTests: XCTestCase {
    
    var sut: FilmsVC!

    override func setUp() {
        super.setUp()
        sut = FilmsVC(category: FilmCategory(uid: 1))
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
