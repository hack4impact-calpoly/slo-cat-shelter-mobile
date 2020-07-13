////
////  EventViewModel.swift
////  transitions mental health assoc
////
////  Created by Jillian Quinn on 7/12/20.
////  Copyright © 2020 Hack4Impact. All rights reserved.
////
//
//import Foundation
//import Combine
//import SwiftUI
//import CoreData
//
//class EventViewModel: ObservableObject {
//    //@Published var cats = CatList(results: [])
//    //@Published var cats = CatList(results: [])
//    @Published var events : CatList2 = []
//    @Published var eventloading = false
//
//    let service: ServiceProtocol
//    init(service: ServiceProtocol = NetworkManager()) {
//        self.service = service
//    }
//
//    func loadData() {
//        self.loading = true
//        service.fetchCats { cats in
//            self.loading = false
//            guard let cats = cats else { return }
//            //self.cats.results = cats
//            self.cats = cats
//        }
//    }
//
//}
//
//
//
//
//
//struct EventList : View {
//    @ObservedObject var viewmodel = CatViewModel()
//    var body: some View {
//        NavigationView {
//            VStack (alignment: .center){
//                if viewmodel.loading {
//                    Text("Loading ...")
//                } else {
//                    if (viewmodel.cats.count > 0) {
//                        List() {
//                            ForEach (viewmodel.cats, id: \.self) { cat in
//                                // List(viewmodel.cats) { cat in
//                                //if (viewmodel.cats.results.count > 0) {
//                                //List(viewmodel.cats.results) { cat in
//                                NavigationLink(destination: CatDetails(cat: cat)){
//                                    CatRow(cat: cat)
//                                }.buttonStyle(PlainButtonStyle())
//                            }
//                        //Spacer()
//                        //Spacer()
//                        Spacer()
//                    }
//                    }
//                    else {
//                        VStack(alignment: .center) {
//                            Text("No cats")
//                        }
//                    }
//
//                }
//            }
//            .onAppear {
//                self.viewmodel.loadData()
//            }
//            .navigationBarTitle(Text("Cats"))
//        }
//    }
//}
//
//
//
//
//
//
//struct ContentView : View {
//    //  @ObservedObject var networkManager = NetworkManager()
//    @ObservedObject var viewmodel = CatViewModel()
//    var body: some View {
//        NavigationView {
//            VStack (alignment: .center){
//                if viewmodel.loading {
//                    Text("Loading ...")
//                } else {
//                    if (viewmodel.cats.count > 0) {
//                        List() {
//                            ForEach (viewmodel.cats, id: \.self) { cat in
//                                // List(viewmodel.cats) { cat in
//                                //if (viewmodel.cats.results.count > 0) {
//                                //List(viewmodel.cats.results) { cat in
//                                NavigationLink(destination: CatDetails(cat: cat)){
//                                    CatRow(cat: cat)
//                                }.buttonStyle(PlainButtonStyle())
//                            }
//                        //Spacer()
//                        //Spacer()
//                        Spacer()
//                    }
//                    }
//                    else {
//                        VStack(alignment: .center) {
//                            Text("No cats")
//                        }
//                    }
//
//                }
//            }
//            .onAppear {
//                self.viewmodel.loadData()
//            }
//            .navigationBarTitle(Text("Cats"))
//        }
//    }
//}
//
//#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//#endif
//
//
//
//
//
//
//
//
//
//
//
//
//struct CatRow : View {
//    var cat: Cat
//
//    var body: some View {
//        //        HStack {
//        //            URLImage(URL(string:  "\(BASE_IMAGE_URL)\(cat.id)")!, delay: 0.25) { proxy in
//        //                proxy.image.resizable()
//        //                    .frame(width: 90, height: 120)
//        //
//        //            }
//        VStack {
//            Spacer()
//            HStack {
//                Text(cat.name)
//                    .foregroundColor(.blue)
//                    .lineLimit(nil)
//                Spacer()
//            }
//            //                HStack {
//            //                    Text(cat.breed).foregroundColor(.gray)
//            //                    //Spacer()
//            //                   // Text("Age: \(cat.age)")
//            //                }
////            HStack {
////                Text("Status: \(cat.status)")
////                    .foregroundColor(.gray)
////                    .lineLimit(nil)
////                Spacer()
////            }
//            HStack {
//                Group {
//                    Text("Status: \(cat.status)")
//                        .foregroundColor(.gray)
//                        .lineLimit(nil)
//                    Spacer()
//                Text("Age: \(cat.age)")
//                    .foregroundColor(.gray)
//                    .lineLimit(nil)
//                Spacer()
//                }
//            }
//            HStack {
//                Text("Breed: \(cat.breed)")
//                    .foregroundColor(.gray)
//                    .lineLimit(nil)
//                Spacer()
//            }
//            Spacer()
////            HStack {
////                Text("Age: \(cat.age)")
////                    .foregroundColor(.gray)
////                    .lineLimit(nil)
////                Spacer()
////            }
//            //}
//        }.frame(height: 60)
//    }
//}
//
//
//
//
//
//
//
//
//
//
//class NetworkManager : ServiceProtocol {
//
//    func fetchCats(completion: @escaping ([Cat]?) -> Void) {
//        //loadDataByAlamofire(completion)
//        loadDataNormal(completion)
//    }
//
//    private func loadDataNormal(_ completion: @escaping ([Cat]?) -> Void) {
//        guard let url = URL(string: "\(api_url_base)\(api_key)") else { return }
//        URLSession.shared.dataTask(with: url){ (data, _, _) in
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//            guard let cats = try? JSONDecoder().decode(CatList2.self, from: data) else {
//                completion(nil)
//                return
//            }
//            DispatchQueue.main.async {
//                //completion(cats.results)
//                completion(cats)
//            }
//        }.resume()
//    }
//
//    private func loadDataByAlamofire(_ completion: @escaping ([Cat]?) -> Void) {
//        AF.request("\(api_url_base)\(api_key)").responseJSON{ response in
//                guard let data = response.data else {
//                    completion(nil)
//                    return
//                }
//               // var datadict = ["results": data]
//                guard let cats = try? JSONDecoder().decode(CatList2.self, from: data) else {
//                    completion(nil)
//                    return
//                }
//                DispatchQueue.main.async {
//                    completion(cats)
//                }
//        }
//    }
//}
