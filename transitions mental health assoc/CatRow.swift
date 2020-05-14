//
//  CatRow.swift
//  transitions mental health assoc
//
//  Created by Jillian Quinn on 5/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import URLImage
import SwiftUI

struct CatRow : View {
    var cat: Cat
    
    var body: some View {
        //        HStack {
        //            URLImage(URL(string:  "\(BASE_IMAGE_URL)\(cat.id)")!, delay: 0.25) { proxy in
        //                proxy.image.resizable()
        //                    .frame(width: 90, height: 120)
        //
        //            }
        VStack {
            Spacer()
            HStack {
                Text(cat.name)
                    .foregroundColor(.blue)
                    .lineLimit(nil)
                Spacer()
            }
            //                HStack {
            //                    Text(cat.breed).foregroundColor(.gray)
            //                    //Spacer()
            //                   // Text("Age: \(cat.age)")
            //                }
//            HStack {
//                Text("Status: \(cat.status)")
//                    .foregroundColor(.gray)
//                    .lineLimit(nil)
//                Spacer()
//            }
            HStack {
                Group {
                    Text("Status: \(cat.status)")
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    Spacer()
                Text("Age: \(cat.age)")
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
//            HStack {
//                Text("Age: \(cat.age)")
//                    .foregroundColor(.gray)
//                    .lineLimit(nil)
//                Spacer()
//            }
            //}
        }.frame(height: 60)
    }
}
