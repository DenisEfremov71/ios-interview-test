//
//  FilmCategoryTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class FilmCategoryTests: XCTestCase {
    
    var sut: FilmCategory!
    let arrayOfAllCategories = [FilmCategory(uid: 1), FilmCategory(uid: 2), FilmCategory(uid: 3)]

    override func setUp() {
        super.setUp()
        sut = FilmCategory(uid: 1)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Initialization

    func testInit_WhenInitialized_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }

    func testInit_WhenInitializedWithUidOne_CategoryAndUidShouldBeSet() {
        XCTAssertEqual(sut.uid, 1)
        XCTAssertEqual(sut.category, FilmCategory.Category.Action)
    }
    
    func testInit_WhenInitializedWithUidTwo_CategoryAndUidShouldBeSet() {
        let filmCategory = FilmCategory(uid: 2)
        XCTAssertEqual(filmCategory.uid, 2)
        XCTAssertEqual(filmCategory.category, FilmCategory.Category.Comedy)
    }
    
    func testInit_WhenInitializedWithUidThree_CategoryAndUidShouldBeSet() {
        let filmCategory = FilmCategory(uid: 3)
        XCTAssertEqual(filmCategory.uid, 3)
        XCTAssertEqual(filmCategory.category, FilmCategory.Category.Drama)
    }
    
    func testInit_WhenInitializedWithUidFour_CategoryAndUidShouldBeSet() {
        let filmCategory = FilmCategory(uid: 4)
        XCTAssertEqual(filmCategory.uid, 4)
        XCTAssertEqual(filmCategory.category, FilmCategory.Category.Other)
    }
    
    // MARK: - Categories
    
    func testAllCategories_ShouldReturnArrayOfAllCategories() {
        XCTAssertEqual(FilmCategory.allCategories(), arrayOfAllCategories)
    }
    
}
