//
//  FilmCategoriesVCTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class FilmCategoriesVCTests: XCTestCase {
    
    var sut: FilmCategoriesVC!

    override func setUp() {
        super.setUp()
        sut = FilmCategoriesVC()
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
    
    func testInit_TableView_ShouldNotBeNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testInit_AppDelegate_ShouldNotBeNil() {
        XCTAssertNotNil(sut.appDelegate)
    }
    
    // MARK: - Table view data source and delegate
    
    func testDataSource_ViewDidLoad_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource is FilmCategoriesVC)
    }
    
    func testDelegate_ViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is FilmCategoriesVC)
    }
    
    func testTableView_ViewDidLoad_SameObjectForDataSourceAndDelegate() {
        XCTAssertEqual(sut.tableView.dataSource as! FilmCategoriesVC, sut.tableView.delegate as! FilmCategoriesVC)
    }
    
    // MARK: - Table view sections
    
    func testTableViewSections_Count_ReturnsOne() {
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
    }

}
