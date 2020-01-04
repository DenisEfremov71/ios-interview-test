//
//  FilmDetailVCTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class FilmDetailVCTests: XCTestCase {
    
    var sut: FilmDetailVC!

    override func setUp() {
        super.setUp()
        sut = FilmDetailVC()
        sut.appDelegate.filmDetailPresenter.film = Film(uid: 1, name: "Avengers: Infinity War", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://assets.eventbase.com/apps/ios-interview-project/images/avg.jpg")!, categoryId: [1], venueId: 1, state: FilmImageState.new, image: UIImage(named: "Placeholder"))
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