//
//  MockExtensions.swift
//  ios-interview-testTests
//
//  Created by Denis Efremov on 2020-01-04.
//  Copyright © 2020 Eventbase. All rights reserved.
//

import Foundation
import UIKit
@testable import ios_interview_test

extension FilmsVCTests {
    
    class FilmVCTableViewMock: UITableView {
        var cellDequeuedProperly = false
        
        class func initMock(dataSource: FilmsVC) -> FilmVCTableViewMock {
            let mock = FilmVCTableViewMock(frame: CGRect(x: 0, y: 0, width: 300, height: 500), style: .plain)
            mock.dataSource = dataSource
            mock.register(FilmCellMock.self, forCellReuseIdentifier: dataSource.cellId)
            return mock
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellDequeuedProperly = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class FilmCellMock: FilmCell {
        var filmData: Film?
        
        override func update(film: Film) {
            filmData = film
        }
    }
    
}

extension FilmTests {
    
//    class FilmMockup: Film {
//        
//        
//        
//    }
    
}
