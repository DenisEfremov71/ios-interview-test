//
//  FilmPresenterTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class FilmPresenterTests: XCTestCase {

    var sut: FilmPresenterMockup!
    let avengersMovie = Film(uid: 1, name: "Avengers: Infinity War", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://s3.amazonaws.com/mobile.scribd.com/ios-interview-test/avg.jpg")!, categoryId: [1], venueId: 1, state: FilmImageState.new, image: UIImage(named: "Placeholder"))
    let avengersMovieMultipleCAtegories = Film(uid: 1, name: "Avengers: Infinity War", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://s3.amazonaws.com/mobile.scribd.com/ios-interview-test/avg.jpg")!, categoryId: [1,2,3], venueId: 1, state: FilmImageState.new, image: UIImage(named: "Placeholder"))
    
    override func setUp() {
        super.setUp()
        sut = FilmPresenterMockup()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Initialization
    
    func testInit_WhenInitialized_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInit_WhenInitialized_FilmCacheShouldNotBeNil() {
        XCTAssertNotNil(sut.filmCache)
    }
    
    func testInit_WhenInitialized_FilmArrayShouldBeEmpty() {
        XCTAssertNotNil(sut.films)
        XCTAssertTrue(sut.films.count == 0)
    }
    
    // MARK: - JSON decoding
    
    func testJSONDecoding_WhenReceivedJSONData_ParsesDataIntoArrayOfFilms() {
        sut.resourceName = "movielist"
        sut.getFilms(category: 1) { (success, error) in
            if success {
                XCTAssertEqual(self.sut.films[0], self.avengersMovie)
            } else {
                XCTFail(error!.localizedDescription)
            }
        }
    }
    
    func testJSONDecoding_WhenReceivedJSONDataWithMultipleCategories_ParsesDataIntoArrayOfFilms() {
        sut.resourceName = "movielist_multiple_categories"
        sut.getFilms(category: 1) { (success, error) in
            if success {
                XCTAssertEqual(self.sut.films[0], self.avengersMovieMultipleCAtegories)
            } else {
                XCTFail(error!.localizedDescription)
            }
        }
    }
    
    // MARK: - Image cache
    
    func testImageCache_WhenImageIsNotInCache_ItIsStoredInCache() {
        var cachedImage = sut.getFilmImageFromCache(for: avengersMovie.thumbnailUrl.absoluteString as NSString)
        XCTAssertNil(cachedImage)
        sut.storeImageInCache(for: avengersMovie)
        cachedImage = sut.getFilmImageFromCache(for: avengersMovie.thumbnailUrl.absoluteString as NSString)
        XCTAssertEqual(avengersMovie.image, cachedImage!.image)
    }

}
