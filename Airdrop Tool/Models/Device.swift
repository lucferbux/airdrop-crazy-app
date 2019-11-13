//
//  Device.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 17/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI
import SocketIO

typealias Devices = [Device]

struct Device: Hashable, Codable, Identifiable, SocketData {
    var id: String
    var airdrop: String
    var state: String
    var os: String
    var device: String
    var time: Double
    var rssi: Int
    var header: String
    var data: String
    
    
    func getImage() -> String {
        switch self.device {
        case "iPhone":
            return "iphone"
        case "iPad":
            return "ipad"
        case "AirPods":
            return "airpods"
        case "MacBook":
            return "mac"
        case "Homepod":
        return "homepod"
        case "Watch":
            return "watch"
        case "iPhone/iPad":
            return "iphoneipad"
        default:
            return "iphone"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "mac"
        case state = "state"
        case airdrop = "airdrop"
        case os = "os"
        case time = "time"
        case rssi = "rssi"
        case device = "device"
        case header = "header"
        case data = "data"
    }
    
    
    
}

extension Device {
    // Created to give custom values if json malformed
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.state = try values.decodeIfPresent(String.self, forKey: .state) ?? ""
        self.airdrop = try values.decodeIfPresent(String.self, forKey: .airdrop) ?? ""
        self.os = try values.decodeIfPresent(String.self, forKey: .os) ?? ""
        self.time = try values.decodeIfPresent(Double.self, forKey: .time) ?? 1571397152
        self.device = try values.decodeIfPresent(String.self, forKey: .device) ?? ""
        self.header = try values.decodeIfPresent(String.self, forKey: .header) ?? ""
        self.data = try values.decodeIfPresent(String.self, forKey: .data) ?? ""
        self.rssi = try values.decodeIfPresent(Int.self, forKey: .rssi) ?? 0
    }
}


