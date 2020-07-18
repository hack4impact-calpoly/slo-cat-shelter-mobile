//
//  ContentView.swift
//  transitions mental health assoc
//
//  Created by Jillian Quinn on 5/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//
import Foundation
import SwiftUI

struct ContentView : View {
    //  @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var viewmodel = CatViewModel()
    var body: some View {
        NavigationView {
            VStack (alignment: .center){
                if viewmodel.loading {
                    Text("Loading ...")
                } else {
                    if (viewmodel.cats.count > 0) {
                        List() {
                            ForEach (viewmodel.cats, id: \.self) { cat in
                                // List(viewmodel.cats) { cat in
                                //if (viewmodel.cats.results.count > 0) {
                                //List(viewmodel.cats.results) { cat in
                                NavigationLink(destination: CatDetails(cat: cat)){
                                    CatRow(cat: cat)
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



