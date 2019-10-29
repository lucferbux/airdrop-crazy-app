//
//  Person.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 27/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI
import SocketIO

typealias People = [Person]

struct Person: Hashable, Codable, Identifiable, SocketData {
    var id: String
    var name: String
    var carrier: String
    var number: String
    var country: String
    var gender: String
    
    func getImage() -> String {
        switch self.gender {
        case "M":
            return "💁🏻‍♂️"
        case "F":
            return "💁🏻‍♀️"
        default:
            return "👤"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "hash"
        case name = "name"
        case carrier = "carrier"
        case number = "number"
        case country = "country"
        case gender = "gender"
    }
}

extension Person {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.carrier = try values.decodeIfPresent(String.self, forKey: .carrier) ?? ""
        self.number = try values.decodeIfPresent(String.self, forKey: .number) ?? ""
        self.country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? ""
    }
}
