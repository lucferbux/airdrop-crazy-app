//
//  WebService.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 18/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import Foundation
import SocketIO


/// Web Service connection class
class WebService {
    
    var socket: SocketIOClient!
    var manager: SocketManager!
    
    init() {}
    
    
    /// Set the server connection and returns the data obtained in the socket established
    /// - Parameter url: Url of the local server
    /// - Parameter completion: Data obtained
    func setServer(url: String, completion: @escaping (Devices, People, Bool) -> ()) {
        self.manager = SocketManager(socketURL: URL(string: url)!, config: [.compress])
        self.socket = manager.defaultSocket
        
        self.socket.on(clientEvent: .connect) {data, ack in
            print("Socket connected")
        }
        
        self.socket.on("after connect") {data, ack in
            print("Established connection")
        }
        
        self.socket.on("device_detected") {data, ack in
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data[0])
                let decoder = JSONDecoder()
                let result = try decoder.decode(Result.self, from: jsonData)
                completion(result.devices, result.people, false)
            } catch {
                print(error)
            }
            
        }

        self.socket.connect()
    }
    
    
    func getDevicesSocket() {
        self.socket?.emit("device_received")
    }
    
}
