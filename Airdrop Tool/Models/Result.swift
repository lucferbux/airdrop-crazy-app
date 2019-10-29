//
//  Result.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 27/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI
import SocketIO


struct Result: Hashable, Codable, SocketData {
    var devices: Devices
    var people: People
    
    enum CodingKeys: String, CodingKey {
        case devices = "devices"
        case people = "people"
    }
}

extension Result {
    // Created to give custom values if json malformed
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.devices = try values.decodeIfPresent(Devices.self, forKey: .devices) ?? []
        self.people = try values.decodeIfPresent(People.self, forKey: .people) ?? []
    }
}



