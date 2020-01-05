//
//  FilmsVCTests.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-03.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import XCTest
@testable import ios_interview_test

class FilmsVCTests: XCTestCase {
    
    var sut: FilmsVC!
    var tableViewMock: FilmVCTableViewMock!
    
    let avengersMovie = Film(uid: 1, name: "Avengers: Infinity War", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://s3.amazonaws.com/mobile.scribd.com/ios-interview-test/avg.jpg")!, categoryId: [1], venueId: 1, state: FilmImageState.new, image: UIImage(named: "Placeholder"))
    let deadpoolMovie = Film(uid: 2, name: "Deadpool 2", shortDesc: "Lorem Ipsum", duration: 120, thumbnailUrl: URL(string: "https://s3.amazonaws.com/mobile.scribd.com/ios-interview-test/deadpool.jpg")!, categoryId: [1], venueId: 2, state: FilmImageState.new, image: UIImage(named: "Placeholder"))

    override func setUp() {
        super.setUp()
        sut = FilmsVC(category: FilmCategory(uid: 1))
        sut.loadViewIfNeeded()
        tableViewMock = FilmVCTableViewMock.initMock(dataSource: sut)
        sut.appDelegate.filmPresenter.films = [avengersMovie, deadpoolMovie]
        tableViewMock.reloadData()
    }

    override func tearDown() {
        tableViewMock = nil
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
    
    func testInit_FilmCategory_ShouldNotBeNil() {
        XCTAssertNotNil(sut.currentFilmCategory)
    }
    
    func testInit_PendingOperationsQueue_ShouldNotBeNil() {
        XCTAssertNotNil(sut.pendingOperations)
    }
    
    // MARK: - Table view data source and delegate
    
    func testDataSource_ViewDidLoad_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource is FilmsVC)
    }
    
    func testDelegate_ViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is FilmsVC)
    }
    
    func testTableView_ViewDidLoad_SameObjectForDataSourceAndDelegate() {
        XCTAssertEqual(sut.tableView.dataSource as! FilmsVC, sut.tableView.delegate as! FilmsVC)
    }
    
    // MARK: - Table view sections
    
    func testTableViewSections_Count_ReturnsOne() {
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
    }
    
    // MARK: - Cells
    
    func testCell_RowAtIndex_ReturnsFilmCell() {
        let cellQueried = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cellQueried is FilmCell)
    }
    
    func testCell_ShouldDequeueCell() {
        _ = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(tableViewMock.cellDequeuedProperly)
    }
    
    func testCell_SectionOneConfig_ShouldSetCellData() {
        let cell = tableViewMock.cellForRow(at: IndexPath(row: 1, section: 0)) as! FilmCellMock
        XCTAssertEqual(cell.filmData, deadpoolMovie)
    }
    
    func testCell_Selection_ShouldSelectFilmData() {
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(sut.appDelegate.filmDetailPresenter.film, deadpoolMovie)
    }

}
