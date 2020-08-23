//
//  ContentView.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 5/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//
import SwiftUI
import Foundation
import Combine
import SwiftUI
import CoreData
import Alamofire
import UIKit

struct ContentView : View {
    //  @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var viewmodel = CatViewModel()
   // @ObservedObject var catSearchState = CatSearchState()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center){
                if viewmodel.loading {
                    Text("Loading ...")
                } else {
                    if (viewmodel.cats.count > 0) {
                        List() {
                            ForEach (viewmodel.cats.sorted(by: { $0.name < $1.name }), id: \.self) { cat in
                                NavigationLink(destination: CatDetails(cat: cat, photos: self.viewmodel.photoDict[cat.id ?? 3] ?? PhotoElement(catID: 100, photourl: "https://img.icons8.com/carbon-copy/100/000000/cat.png", photoDescription: "default", uploadedAt: DateFormatter().string(from: Date()), hidden: false))){
                                    CatRow(cat: cat, photos: self.viewmodel.photoDict[cat.id ?? 3] ?? PhotoElement(catID: 100, photourl: "https://img.icons8.com/carbon-copy/100/000000/cat.png", photoDescription: "default", uploadedAt: DateFormatter().string(from: Date()), hidden: false))
                                }.buttonStyle(PlainButtonStyle())
                            }
                            Spacer()
                        }
                    }
                    else {
                        VStack(alignment: .center) {
                            Text("No cats")
                        }
                    }
                    
                }
            }
            .onAppear {
                self.viewmodel.loadData()
            }
            .navigationBarTitle(Text("Cats"))
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif




