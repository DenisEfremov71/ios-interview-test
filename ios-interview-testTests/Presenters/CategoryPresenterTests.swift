//
//  CategoryPresenterTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class CategoryPresenterTests: XCTestCase {
    
    var sut: CategoryPresenter!

    override func setUp() {
        super.setUp()
        sut = CategoryPresenter()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInit_WhenInitialized_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }

    func testInit_WhenInitialized_ShouldHaveAllCategories() {
        let arrayOfAllCategories = [FilmCategory(uid: 1), FilmCategory(uid: 2), FilmCategory(uid: 3)]
        XCTAssertEqual(sut.categories, arrayOfAllCategories)
    }
}
