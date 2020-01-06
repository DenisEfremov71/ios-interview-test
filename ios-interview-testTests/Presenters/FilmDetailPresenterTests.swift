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
    
    var sut: FilmDetailPresenterMockup!
    let avengersMovie = Film(uid: 1, name: "Avengers: Infinity War", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://s3.amazonaws.com/mobile.scribd.com/ios-interview-test/avg.jpg")!, categoryId: [1], venueId: 1, state: FilmImageState.new, image: UIImage(named: "Placeholder"))
    let venueOne = Venue(uid: 1, name: "AMC Kabuki", address: "1881 Post St, San Francisco, CA 94115")

    override func setUp() {
        super.setUp()
        sut = FilmDetailPresenterMockup(film: avengersMovie)
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
    
    // MARK: - JSON decoding
    
    func testJSONDecoding_WhenReceivedJSONData_ParsesDataIntoVenueObject() {
        sut.fetchVenue { (venue, error) in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            XCTAssertNotNil(venue)
            XCTAssertEqual(venue, self.venueOne)
        }
    }
    
    // MARK: - Image cache
    
    func testImageCache_WhenImageIsNotInCache_ItIsStoredInCache() {
        var cachedImage = sut.getFilmImageFromCache(for: sut.film!.thumbnailUrl.absoluteString as NSString)
        XCTAssertNil(cachedImage)
        sut.storeImageInCache(for: sut.film!)
        cachedImage = sut.getFilmImageFromCache(for: sut.film!.thumbnailUrl.absoluteString as NSString)
        XCTAssertEqual(sut.film!.image, cachedImage)
    }
}
