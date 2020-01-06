//
//  venue.swift
//  ios-interview-test
//

import Foundation

struct Venue: Equatable {
    
    let uid: Int
    let name: String
    let address: String
    
    public enum Result<Venue> {
        case success(Venue)
        case failure(Error)
    }
    
    static func ==(lhs: Venue, rhs: Venue) -> Bool {
        return lhs.uid == rhs.uid && lhs.name == rhs.name && lhs.address == rhs.address
    }
}

extension Venue: Decodable {
    enum venueKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case address = "address"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: venueKeys.self)
        let uid: Int = try container.decode(Int.self, forKey: .uid)
        let name: String = try container.decode(String.self, forKey: .name)
        let address: String = try container.decode(String.self, forKey: .address)

        self.init(uid: uid, name: name, address: address)
    }
}
