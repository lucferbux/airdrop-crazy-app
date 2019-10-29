//
//  CardPersonExpand.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 27/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI

struct CardPersonExpand: View {
    var person: Person
    
    var body: some View {
        ZStack {
            PersonImage(image: person.getImage())
                .offset(x: 40, y: 0)
            
            DetailPerson(person: person)
                .offset(x: -40, y: 0)
        }
    }
}

struct DetailPerson: View {
    var person: Person
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("cardBackground"))
                .shadow(radius: 20)
            
            VStack {
                HStack {
                    Text(person.name)
                        .foregroundColor(Color.gray)
                        .padding(.top, 10)
                    Spacer()
                }
                .padding()
                HStack {
                    
                    
                    VStack {
                        PersonPropExp(title: "Name", icon: "phone", status: person.number)
                        
                        PersonPropExp(title: "Carrier", icon: "antenna.radiowaves.left.and.right", status: person.carrier)
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                    
                }
                Spacer()
            }
        }
        .frame(minWidth: 200,  maxWidth:240, minHeight: 200, maxHeight: 200)
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}



struct PersonPropExp: View {
    var title = "Airdrop"
    var icon = "airplayaudio"
    var status = "On"
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(.white)
                .background(Color("button"))
                .cornerRadius(12)
            VStack(alignment: .leading) {
                Text(status.capitalized)
                    .font(.caption)
                
            }
            .frame(width: 120, height: 50, alignment: .leading)
        }
    }
}

struct PersonImage: View {
    var image = "💁🏻‍♂️"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("primary"))
                .shadow(radius: 20)
            
            
            HStack {
                Spacer()
                Text(image)
                    .font(.system(size: 120))
                    .offset(x: 60, y: 0)
                    .frame(width: 135, height: 135, alignment: .trailing)
                    .mask(RoundedRectangle(cornerRadius: 0))
                
                
            }
        }
        .frame(minWidth: 200,  maxWidth:250, minHeight: 180, maxHeight: 180)
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

struct CardPersonExpand_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardPersonExpand(person: personData[0]).previewDevice("iPad Pro (11-inch)")
            CardPersonExpand(person: personData[0]).previewDevice("iPhone Xs").colorScheme(.dark)
            CardPersonExpand(person: personData[0]).previewDevice("iPhone Xs Max")
        }
    }
}
