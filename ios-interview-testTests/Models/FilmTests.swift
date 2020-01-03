//
//  FilmTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class FilmTests: XCTestCase {
    
    var sut: Film!

    override func setUp() {
        super.setUp()
        sut = Film(uid: 1, name: "Avengers: Infinity War", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://assets.eventbase.com/apps/ios-interview-project/images/avg.jpg")!, categoryId: [1], venueId: 1, state: FilmImageState.new, image: UIImage(named: "Placeholder"))
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
        XCTAssertEqual(sut.name, "Avengers: Infinity War")
        XCTAssertEqual(sut.shortDesc, "Lorem Ipsum")
        XCTAssertEqual(sut.duration, 120)
        XCTAssertEqual(sut.thumbnailUrl, URL(string: "https://assets.eventbase.com/apps/ios-interview-project/images/avg.jpg")!)
        XCTAssertEqual(sut.categoryId, [1])
        XCTAssertEqual(sut.venueId, 1)
        XCTAssertEqual(sut.state, FilmImageState.new)
        XCTAssertEqual(sut.image, UIImage(named: "Placeholder"))
    }
}
