//
//  AirdropDevices.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 17/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI

struct AirdropDevices: View {
    @ObservedObject var peopleList: ResultViewModel
    var people: People = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Text("Airdrop Identities")
                    .font(.title)
                    .fontWeight(.bold)
                    
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(.primary)
                }
                .frame(width: 25, height: 25)
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
            
            VStack {
                ScrollView(.vertical) {
                    ForEach(peopleList.people.filter { person in
                        
                        !person.number.isEmpty
                        
                    }) { person in
                        CardPersonExpand(person: person)
                            .frame(maxWidth: .infinity, minHeight: 220)
                            .padding(.top, 25)
                    }
                }
            }
           
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct AirdropDevices_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AirdropDevices(peopleList: ResultViewModel(), people: personData).previewDevice("iPhone X").colorScheme(.light)

        }
    }
}


