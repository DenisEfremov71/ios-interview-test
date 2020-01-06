//
//  FilmFetchingTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-05.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class FilmFetchingTests: XCTestCase {
    
    var sut: FilmPresenterMockup!
    let getFilmsEndpoint = EndPoints.movieUrlString

    override func setUp() {
        sut = FilmPresenterMockup()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Async operations
    
    func testAsyncOperation_CallGetFilmsEndpoint_GetListOfFilms() {
        
        let filmListExpectation = expectation(description: "filmListFetched")
        
        sut.endpoint = getFilmsEndpoint
        sut.getFilms(category: 1) { (success, error) in
            if error != nil {
                XCTFail(error!.localizedDescription)
            }
            if success {
                filmListExpectation.fulfill()
                XCTAssertTrue(self.sut.films.count > 0)
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
