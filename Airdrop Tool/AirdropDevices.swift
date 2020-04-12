//
//  AirdropDevices.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 17/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI

struct HoverCompatible: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.largeTitle)
    }
}
struct CloseButton: View {
    var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .foregroundColor(.primary)
        }
        .frame(width: 25, height: 25)
    }
}

@available(iOS 13.4, *)
struct CardPersonExpandHover: View {
    @State private var over = false
    var person: Person
    var body: some View  {
        CardPersonExpand(person: person)
            .scaleEffect(over ? 1.05 : 1.0)
            .onHover{ over in
                self.over = over
            }
    }
}


struct AirdropDevices: View {
    @ObservedObject var peopleList: ResultViewModel
    var people: People = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    func getHoveredCard(person: Person) -> AnyView {
        if #available(iOS 13.4, *) {
            return AnyView(
                CardPersonExpandHover(person: person)
                .animation(.default)
                .frame(maxWidth: .infinity, minHeight: 220)
                .padding(.top, 25)
            )
        } else {
            return AnyView(
                CardPersonExpand(person: person)
                .frame(maxWidth: .infinity, minHeight: 220)
                .padding(.top, 25)
            )
        }
    }
    
    func getHoveredButton(presentationMode: Binding<PresentationMode>) -> AnyView {
        if #available(iOS 13.4, *) {
            return AnyView(
                CloseButton(presentationMode: presentationMode).hoverEffect()
            )
        } else {
            return AnyView(
                CloseButton(presentationMode: presentationMode)
            )
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Airdrop Identities")
                    .font(.title)
                    .fontWeight(.bold)
                    
                Spacer()
                getHoveredButton(presentationMode: presentationMode)
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
            
            VStack {
                ScrollView(.vertical) {
                    ForEach(peopleList.people.filter { person in
                        
                        !person.number.isEmpty
                        
                    }) { person in
                        self.getHoveredCard(person: person)
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



