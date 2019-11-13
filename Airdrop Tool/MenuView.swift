//
//  MenuView.swift
//  SwiftUI-DesignCode
//
//  Created by Meng To on 2019-06-22.
//  Copyright © 2019 Meng To. All rights reserved.
//

import SwiftUI

struct MenuView : View {
    var menuItems = ["iPhone", "iPad", "Mac", "Watch", "Homepod", "Airpods"]
    @Binding var menu: [Menu]
    var showModal = false
    var showSettings = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text("Filter")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                ForEach(menu.indices) { index in
                    MenuItem(menu: self.$menu[index])
                }
                
                Spacer()
                                
                HStack {
                    Text("Version 0.0.1").foregroundColor(.gray)
                    Spacer()
                }
            }
            .frame(maxWidth: 360)
                .padding(30).padding(.top, 30)
                .background(Color("cardBackground"))
                .cornerRadius(30)
                .padding(.top, 44)
                .padding(.trailing, 50)
                .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 20)
                .shadow(color: Color("buttonShadow"), radius: 30, x: 0, y: 10)
            
            Spacer()
        }
    }
}

struct MenuItem : View {
    @Binding var menu: Menu
    var body: some View {
        return HStack {
            Toggle(isOn: $menu.enabled) {
                Text(menu.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading, 10)
                    
                    }
                    .padding(10)
            }
            
    }
}



#if DEBUG
struct MenuView_Previews : PreviewProvider {
    @State static var menuFilter: [Menu] = ResultViewModel().menu
    static var previews: some View {
        MenuView(menu: $menuFilter)
    }
}
#endif
