//
//  CardDetailExpand.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 24/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI

struct CardDetailExpand: View {
    var device: Device
    
    var body: some View {
        ZStack {
            
            HStack {
            Spacer()
            DetailImage(image: device.getImage())
            }
            
            HStack {
                DetailDevice(device: device)
                           
            Spacer()
            
            }
            
           
        }
        .frame(minWidth: 180,  maxWidth:360)
        
        
    }
}

struct DetailDevice: View {
    var device: Device
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("cardBackground"))
                .shadow(radius: 20)
            
            VStack {
                HStack {
                    Text(device.id)
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                .padding()
                HStack {
                    
                    
                    VStack {
                        DevicePropExp(title: "Airdrop", icon: "airplayaudio", status: device.airdrop)
                        
                        DevicePropExp(title: "Version", icon: "info.circle", status: device.os)
                    }
                    
                    
                    
                    VStack {
                        DevicePropExp(title: "RSSI", icon: "location", status: String(device.rssi))
                        DevicePropExp(title: "Status", icon: "questionmark.circle", status: device.state)
                    }
                    
                    
                }
                Spacer()
            }
        }
        .frame(minWidth: 150,  maxWidth:250, minHeight: 200, maxHeight: 200)
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}



struct DevicePropExp: View {
    var title = "Airdrop"
    var icon = "airplayaudio"
    var status = "On"
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .imageScale(.large)
                .frame(minWidth: 30,  maxWidth:33, minHeight: 30, maxHeight: 33)
                .foregroundColor(.white)
                .background(Color("button"))
                .cornerRadius(12)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text(status)
                    .font(.caption)
            }
            .frame(minWidth: 55,  maxWidth:70, minHeight: 50, maxHeight: 50, alignment: .leading)
        }
    }
}

struct DetailImage: View {
    var image = "iphone"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("primary"))
                .shadow(radius: 20)
                
            
            HStack {
                Spacer()
                Image(image)
                    .resizable()

                    .offset(x: 50, y: 0)
                    .frame(width: 135, height: 135, alignment: .trailing)
                .mask(RoundedRectangle(cornerRadius: 0))
                
            }
        }
        .frame(minWidth: 180,  maxWidth:250, minHeight: 180, maxHeight: 180)
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

struct CardDetailExpand_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardDetailExpand(device: devicesData[0]).previewDevice("iPad Pro (11-inch)")
            CardDetailExpand(device: devicesData[0]).previewDevice("iPhone Xs").colorScheme(.dark)
            CardDetailExpand(device: devicesData[0]).previewDevice("iPhone Xs Max")
            CardDetailExpand(device: devicesData[0]).previewLayout(.fixed(width: 320, height: 400))
        }
    }
}
