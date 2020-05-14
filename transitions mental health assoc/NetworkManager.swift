//
//  NetworkManager.swift
//  transitions mental health assoc
//
//  Created by Jillian Quinn on 5/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//
import Alamofire
import Foundation
import Combine
import CoreData

fileprivate let api_key = ""
fileprivate let api_url_base = "https://cpcp-cats.herokuapp.com/api/cats/"


class NetworkManager : ServiceProtocol {
    
    func fetchCats(completion: @escaping ([Cat]?) -> Void) {
        //loadDataByAlamofire(completion)
        loadDataNormal(completion)
    }
    
    private func loadDataNormal(_ completion: @escaping ([Cat]?) -> Void) {
        guard let url = URL(string: "\(api_url_base)\(api_key)") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let cats = try? JSONDecoder().decode(CatList2.self, from: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                //completion(cats.results)
                completion(cats)
            }
        }.resume()
    }
    
    private func loadDataByAlamofire(_ completion: @escaping ([Cat]?) -> Void) {
        AF.request("\(api_url_base)\(api_key)").responseJSON{ response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
               // var datadict = ["results": data]
                guard let cats = try? JSONDecoder().decode(CatList2.self, from: data) else {
                    completion(nil)
                    return
                }
                DispatchQueue.main.async {
                    completion(cats)
                }
        }
    }
}



/*
class NetworkManager: ObservableObject {
    @Published var cats = CatList(results: [])
    @Published var loading = false
//    private let api_key = ""
//    private let api_url_base = "https://cpcp-cats.herokuapp.com/api/cats/"
    init() {
        loading = true
        loadDataByAlamofire()
        //loadDataNormal()
    }
    
    private func loadDataNormal() {
        guard let url = URL(string: "\(api_url_base)\(api_key)") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let cats = try! JSONDecoder().decode(CatList.self, from: data)
            DispatchQueue.main.async {
                self.cats = cats
                self.loading = false
            }
        }.resume()
    }
    
    private func loadDataByAlamofire() {
        AF.request("\(api_url_base)\(api_key)")
            .responseJSON{ response in
                guard let data = response.data else { return }
                let cats = try! JSONDecoder().decode(CatList.self, from: data)
                DispatchQueue.main.async {
                    self.cats = cats
//                    let i = 0
//                    for cat in self.cats {
//                        cat.id = i
//                        i += 1
//                    }
                    self.loading = false
                }
        }
    }
}
*/

