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
    
    
    private lazy var webService: WebService = WebService()
    
    @Published var devices: Devices = []
    @Published var people: People = []
    @Published var error: Bool = false
    
    
    init() {}
    
    
    /// Add the url of the server in order to perform the connection
    /// - Parameter url: The url of the local server to connect
    func upDateServiceUrl(url: String) {
        webService.setServer(url: url) { (devices, people, error) in
            self.devices = devices
            self.people = people
            self.error = error
        }
    }
    
    /// Fetch the devices obtained
    func fetchDevices() {
        webService.getDevicesSocket()
    }
    
    
    /// Mock method to obtain data
    func fetchFaker() {
        self.devices = devicesData
    }
    
    
}
