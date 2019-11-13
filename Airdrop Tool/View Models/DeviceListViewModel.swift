//
//  DeviceListViewModel.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 18/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


/// View Model of the App Data
final class ResultViewModel: ObservableObject {
    
    var url = ""
    private lazy var webService: WebService = WebService()
    static let sharedInstance = ResultViewModel()
    @Published var devices: Devices = []
    @Published var people: People = []
    @Published var error: Bool = false
    @Published var loading: Bool = false
    @Published var menu: [Menu] = menuData
    
    
    init() {}
    
    
    /// Add the url of the server in order to perform the connection
    /// - Parameter url: The url of the local server to connect
    func upDateServiceUrl(url: String) {
        saveUrl(url: url)
        webService.setServer(url: url) { (devices, people, error) in
            if(!error){
                self.devices = devices
                self.people = people
            }
            self.error = error
            self.loading = false
        }
    }
    
    func saveUrl(url: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(url) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "UrlServer")
        }
    }
    
    /// Fetch the devices obtained
    func fetchDevices() {
        webService.getDevicesSocket()
    }
    
    
    func updateSession() {
        let defaults = UserDefaults.standard
        if let urlDecoded = defaults.object(forKey: "UrlServer") as? Data {
            let decoder = JSONDecoder()
            if let url = try? decoder.decode(String.self, from: urlDecoded){
                self.upDateServiceUrl(url: url)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.fetchDevices()
                }
            }
        }
    }
    
    /// Mock method to obtain data
    func fetchFaker() {
        self.devices = devicesData
    }
    
    
}


struct Menu : Identifiable {
    var id = UUID()
    var title: String
    var enabled: Bool = true
}

//class Menu : ObservableObject {
//  var title: String
//    var id:UUID
//  @Published var enabled: Bool = true
//    
//    init(title: String) {
//        self.title = title
//        self.id = UU
//    }
//}

let menuData = [
    Menu(title: "iPhone/iPad"),
    Menu(title: "iPhone"),
    Menu(title: "iPad"),
    Menu(title: "MacBook"),
    Menu(title: "Watch"),
    Menu(title: "Homepod"),
    Menu(title: "AirPods")
]
