//
//  film.swift
//  ios-interview-test
//

import Foundation
import UIKit

// This enum contains all the possible states a film thumbnail image can be in
enum FilmImageState {
    case new
    case cached
    case downloaded
    case failed
}

struct Film: Equatable {
    
    let uid: Int
    let name: String
    let shortDesc: String
    let duration: Int
    let thumbnailUrl: URL
    let categoryId: [Int]
    let venueId: Int
    
    var state = FilmImageState.new
    var image = UIImage(named: "Placeholder")
    
    static func ==(lhs: Film, rhs: Film) -> Bool {
        return
            lhs.uid == rhs.uid &&
            lhs.name == rhs.name &&
            lhs.shortDesc == rhs.shortDesc &&
            lhs.duration == rhs.duration &&
            lhs.thumbnailUrl == rhs.thumbnailUrl &&
            lhs.categoryId == rhs.categoryId &&
            lhs.venueId == rhs.venueId &&
            lhs.state == rhs.state &&
            lhs.image == rhs.image
    }
}

extension Film: Decodable {
    enum filmKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case shortDesc = "shortDesc"
        case duration = "duration"
        case thumbnailUrl = "thumbnailUrl"
        case category = "category"
        case venue = "venue"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: filmKeys.self)
        let uid: Int = try container.decode(Int.self, forKey: .uid)
        let name: String = try container.decode(String.self, forKey: .name)
        let shortDesc: String = try container.decode(String.self, forKey: .shortDesc)
        let duration: Int = try container.decode(Int.self, forKey: .duration)
        let thumbnailUrl: URL = try container.decode(URL.self, forKey: .thumbnailUrl)
        var categoryId: [Int] = [Int]()
        
        // Assumption: for the "category" type we might received Int or [Int] from the JSON payload
        // so we have to handle the both cases
        if let intValue = try? container.decode(Int.self, forKey: .category) {
            categoryId.append(intValue)
        } else if let intArrayValue = try? container.decode([Int].self, forKey: .category) {
            categoryId = intArrayValue
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid JSON for category ID"))
        }
        
        let venueId: Int = try container.decode(Int.self, forKey: .venue)
        
        self.init(uid: uid, name: name, shortDesc: shortDesc, duration: duration, thumbnailUrl: thumbnailUrl, categoryId: categoryId, venueId: venueId, state: FilmImageState.new, image: UIImage(named: "Placeholder"))
    }
}
