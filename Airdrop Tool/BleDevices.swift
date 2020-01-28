//
//  ContentView.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 15/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct BleDevices: View {
    @ObservedObject var devicesList = ResultViewModel()
    @State var menuFilter: [Menu] = ResultViewModel().menu
    @State var viewState = CGSize.zero
    @State var spin = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var devices: Devices = [] // Mockup data
    var devicesFiltered: Devices {
        self.devicesList.devices.filter { device in
            
            menuFilter.first(where: {
                $0.title == device.device
            })?.enabled ?? false
            
        }
    }
    
    
    @State var show = false
    
    func refreshView() {
        self.devicesList.updateSession()
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Header()
                        .padding(.top, 50)
                        .offset(x: 43)
                    
                    if(UIScreen.main.bounds.width < 600) {
                        ForEach(devicesFiltered) { device in
                            CardDetailExpand(device: device)
                        }
                    } else {
                        if horizontalSizeClass == .regular {
                            ForEach(devicesFiltered.chunked(into: 2), id: \.self){ devChunked in
                                HStack(spacing: 60) {
                                    ForEach(devChunked) { dev in
                                        CardDetailExpand(device: dev)
                                    }
                                }
                            }
                        } else { // compact
                            ForEach(devicesFiltered) { device in
                                CardDetailExpand(device: device)
                            }
                        }
                    }
                    Spacer()
                    
                }
                .blur(radius: show ? 100 : 0)
                .onTapGesture {
                    if(self.show) {
                        self.show.toggle()
                    }
                }
            }
            
            
            VStack {
                HStack {
                    Spacer()
                    HStack(spacing: 10) {
                        QrCodeView(devicesList: devicesList)
                        AirplayView(devicesList: devicesList)
                    }
                    .offset(x: 0, y: 60)
                    .padding(.trailing, 10)
                    
                }
                Spacer()
            }
            
            
            MenuButton(show: $show)
                .blur(radius: 0)
                .animation(.default)
            
            
            MenuView(menu: $menuFilter)
                
                .offset(x: viewState.width)
                .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
                .animation(.default)
                .offset(x: show ? 0 : -UIScreen.main.bounds.width)
                //                .onTapGesture {
                //                    self.show.toggle()
                //                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.viewState = value.translation
                    }
                    .onEnded { value in
                        if self.viewState.width < 100 {
                            self.show = false
                        }
                        self.viewState = .zero
                    }
            )
            
            
            if(devicesList.loading) {
            
                BlurView(style: .systemThinMaterial)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                VStack {
//                    Image(systemName: "arrow.2.circlepath.circle.fill")
//                        .resizable()
//                        .frame(width: 90, height: 90)
//                        .rotationEffect(.degrees(spin ? 360 : 0))
//                        .animation(Animation.easeIn(duration: 0.8).repeatForever(autoreverses: true))
//                        .onAppear() {
//                            self.spin.toggle()
//                    }
                    LottieView(filename: "Loading")
                        .frame(width: 300, height: 300)
                        
                    
                    Button(action: {
                        self.devicesList.loading = false
                    }) {
                        Text("Cancel")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding()
                }
            }
            
            
        }
        .background(Color("background"))
            
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $devicesList.error) {
            Alert(title: Text("Error networking, try again later"))
            
        }
        .onAppear {
            self.refreshView()
        }
        
    }
}

struct Header: View {
    var body: some View {
        HStack {
            Text("Airdrop Crazy")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            
            
        }
        .padding()
    }
}


struct MenuButton : View {
    @Binding var show: Bool
    var body: some View {
        return VStack {
            HStack {
                Button(action: { self.show.toggle() }) {
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                    }.padding(17)
                }
                .frame(width: 90, height: 56)
                .background(Color("cardBackground"))
                .cornerRadius(30)
                .shadow(color: Color("buttonShadow"), radius: 5, y: 5)
                .offset(x: -42, y: 52)
                Spacer()
            }
            Spacer()
        }
    }
}

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
        
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
            .gesture(
                LongPressGesture(minimumDuration: 1.5)
                    .onEnded { _ in
                        self.devicesList.fetchFaker()
                }
            )
                .sheet(isPresented: self.$showAirdrop) {
                    AirdropDevices(peopleList: self.devicesList)
                    
            }
        }
    }
}

struct QrCodeView: View {
    @ObservedObject var devicesList: ResultViewModel
    @State var showAirdrop = false
    @State var showQR = false
    
    var body: some View {
        HStack {
            //            if(devicesList.devices.isEmpty) {
            VStack {
                Image(systemName: "qrcode")
                    .resizable()
                    .padding(10)
                
            }
            .foregroundColor(.white)
            .frame(width: 44, height: 44)
            .background(Color("primary"))
            .cornerRadius(20)
            .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
            .onTapGesture {
                self.showQR.toggle()
            }
            .gesture(
                LongPressGesture(minimumDuration: 1.5)
                    .onEnded { _ in
                        self.devicesList.loading = true
                        self.devicesList.updateSession()
                }
            )
                .sheet(isPresented: self.$showQR) {
                    QRCodeScan() { (url) in
                        self.devicesList.loading = true
                        self.devicesList.upDateServiceUrl(url: url as String)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.devicesList.fetchDevices()
                        }
                        
                    }
            }
            
            //            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BleDevices(devices: devicesData).previewDevice("iPhone X").colorScheme(.light)
            BleDevices(devices: devicesData).previewDevice("iPhone Xs Max")
            BleDevices(devices: devicesData).previewDevice("iPad Pro (11-inch)")
        }
        
    }
}
