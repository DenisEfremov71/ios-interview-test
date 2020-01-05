//
//  FilmDetailPresenterTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class FilmDetailPresenterTests: XCTestCase {
    
    var sut: FilmDetailPresenter!
    let avengersMovie = Film(uid: 1, name: "Avengers: Infinity War", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://s3.amazonaws.com/mobile.scribd.com/ios-interview-test/avg.jpg")!, categoryId: [1], venueId: 1, state: FilmImageState.new, image: UIImage(named: "Placeholder"))

    override func setUp() {
        super.setUp()
        sut = FilmDetailPresenter(film: avengersMovie)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Initialization
    
    func testInit_WhenInitialized_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInit_WhenInitialized_ImageCacheShouldNotBeNil() {
        XCTAssertNotNil(sut.filmCache)
    }

    func testInit_WhenInitializedWithFilm_FilmShouldBeSet() {
        XCTAssertEqual(sut.film, avengersMovie)
    }
    
    
}
