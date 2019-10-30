//
//  ContentView.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 15/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI

struct BleDevices: View {
    @ObservedObject var devicesList = ResultViewModel()
    var devices: Devices = [] // Mockup data
    
    func fetchDevices() {
        devicesList.fetchDevices()
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Header()
                        .padding(.top, 20)
                    ForEach(devicesList.devices) { device in
                        CardDetailExpand(device: device)
                    }
                }
                Spacer()
                
            }
            .padding(.top, 30)
            
            AirplayView(devicesList: devicesList)
                .offset(x: UIScreen.main.bounds.width/2 - 50, y: -UIScreen.main.bounds.height/2 + 84)
            
            QrCodeView(devicesList: devicesList)
                .offset(x: UIScreen.main.bounds.width/2 - 110, y: -UIScreen.main.bounds.height/2 + 84)
            
        }
        .background(Color("background"))
            
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $devicesList.error) {
            Alert(title: Text("Error networking"))
            
        }
    }
}

struct Header: View {
    var body: some View {
        HStack {
            Text("Aidrop Crazy")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            
            
        }
        .padding()
    }
}

struct AirplayView: View {
    @ObservedObject var devicesList: ResultViewModel
    @State var showAirdrop = false
    
    @State var showQR = false
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "airplayaudio")
                    .resizable()
                    .padding(9)
            }
            .frame(width: 44, height: 44)
            .background(Color("secondary"))
            .foregroundColor(.white)
            .cornerRadius(20)
                
            .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
            .onTapGesture {
                self.showAirdrop.toggle()
                
            }
            .sheet(isPresented: self.$showAirdrop) { AirdropDevices(peopleList: self.devicesList) }
        }
    }
}

struct QrCodeView: View {
    @ObservedObject var devicesList: ResultViewModel
    @State var showAirdrop = false
    
    @State var showQR = false
    
    var body: some View {
        HStack {
            if(devicesList.devices.isEmpty) {
                VStack {
                    Image(systemName: "qrcode")
                        .resizable()
                        .padding(10)
                    
                }
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Color("primary"))
                .cornerRadius(20)
                .padding(.trailing, 10)
                .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
                .onTapGesture {
                    //            self.devicesList.fetchDevices()
                    self.showQR.toggle()
                    
                }
                .sheet(isPresented: self.$showQR) {
                    QRCodeScan() { (url) in
                        print(url)
                        self.devicesList.upDateServiceUrl(url: url as String)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.devicesList.fetchDevices()
                        }
                        
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BleDevices(devices: devicesData).previewDevice("iPhone X").colorScheme(.dark)
            BleDevices(devices: devicesData).previewDevice("iPhone Xs Max")
            BleDevices(devices: devicesData).previewDevice("iPad Pro (11-inch)")
        }
        
    }
}
