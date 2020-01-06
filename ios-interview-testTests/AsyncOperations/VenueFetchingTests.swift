//
//  VenueFetchingTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-05.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class VenueFetchingTests: XCTestCase {
    
    var sut: FilmDetailPresenterMockup!
    let getVenueEndpoint = EndPoints.venueUrlString
    let avengersMovie = Film(uid: 1, name: "Avengers: Infinity War", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://s3.amazonaws.com/mobile.scribd.com/ios-interview-test/avg.jpg")!, categoryId: [1], venueId: 1, state: FilmImageState.new, image: UIImage(named: "Placeholder"))
    let avengersMovieVenue = Venue(uid: 1, name: "AMC Kabuki", address: "1881 Post St, San Francisco, CA 94115")

    override func setUp() {
        super.setUp()
        sut = FilmDetailPresenterMockup(film: avengersMovie)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Async operations
    
    func testAsyncOperation_CallGetVenueEndpoint_GetVenue() {
        
        let venueExpectation = expectation(description: "venueFetched")
        
        sut.endpoint = getVenueEndpoint
        sut.fetchVenue { (venue, error) in
            if error != nil {
                XCTFail(error!.localizedDescription)
            }
            if venue != nil {
                venueExpectation.fulfill()
                XCTAssertEqual(venue, self.avengersMovieVenue)
            } else {
                XCTFail("Venue is nil")
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
