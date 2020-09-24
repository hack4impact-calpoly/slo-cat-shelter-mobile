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
    @ObservedObject var eviewmodel = EventViewModel()
    // @ObservedObject var catSearchState = CatSearchState()
    @State var refreshtime: String = "Refresh"
    
    func timeToRefresh()
    {
        if (refreshtime == "END")
        {
            refreshtime = "START"
        }
        else{
            refreshtime = "END"
        }
        self.viewmodel.loadData()
        self.eviewmodel.loadData()
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center){
                if viewmodel.loading {
                    Text("Loading ...").font(.custom("Euphemia UCAS", size: 14.0))
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
                            Text("No cats").font(.custom("Euphemia UCAS", size: 18.0))
                        }
                    }
                    
                }
            }
            .onAppear {
                self.viewmodel.loadData()
            }
                
            .navigationBarTitle(Text("Cats").font(.custom("Euphemia UCAS", size: 14.0)))
            .navigationBarItems(trailing:
                Button(action:timeToRefresh) {
                    Text("Refresh")
                        .font(.custom("Euphemia UCAS", size: 14.0))
                        .padding(6)
                        .background(Color(red: 0.7215686, green: 0.917647, blue: 0.6888888))
                        .foregroundColor(Color.black)
                }
                .cornerRadius(5)
                .background(Color(red: 0.7215686, green: 0.917647, blue: 0.6888888))
                //                .padding()
            )
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




