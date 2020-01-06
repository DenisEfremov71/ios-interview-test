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
    let avengersMovie = Film(uid: 1, name: "Avengers: Infinity War", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://s3.amazonaws.com/mobile.scribd.com/ios-interview-test/avg.jpg")!, categoryId: [1], venueId: 1, state: FilmImageState.new, image: UIImage(named: "Placeholder"))
    let venueOne = Venue(uid: 1, name: "AMC Kabuki", address: "1881 Post St, San Francisco, CA 94115")

    override func setUp() {
        super.setUp()
        sut = FilmDetailVC()
        sut.appDelegate.filmDetailPresenter.film = avengersMovie
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Nil checks

    func testInit_WhenInitialized_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }
    
    // MARK: - Actions
    
    func testVenueButton_WhenClicked_ShouldSetVenueDetailPresenterVenue() {
        sut.currentVenue = venueOne
        sut.venueButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.appDelegate.venueDetailPresenter.venue, sut.currentVenue)
    }

}
