//
//  CatRow.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 5/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import URLImage
import SwiftUI

struct CatRow : View {
    var cat: Cat
    var photos: PhotoElement
    
    var body: some View {
        
                HStack {
                    URLImage(URL(string:  "\(photos.photourl)")!, delay: 0.25) { proxy in
                        proxy.image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 120)
                    }
        
        VStack {
            Spacer()
            HStack {
                Text(cat.name)
                    .foregroundColor(.init(red: 0.53725, green: 0.7725490, blue: 0.46666666666))
                    .lineLimit(nil)
                Spacer()
            }
            HStack {
                Group {
                    Text("Status: \(cat.gender.rawValue)")
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    Spacer()
                Text("Age: \(String(cat.age))")
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                Spacer()
                }
            }
            HStack {
                Text("Breed: \(cat.breed)")
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                Spacer()
            }
            Spacer()
        }.frame(height: 60)
        }
    }
}
