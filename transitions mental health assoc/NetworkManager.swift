//
//  NetworkManager.swift
//  Cal Poly Cat Program App
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

struct PhotoElement: Codable {
    let catID: Int
    let photourl: String
    let photoDescription: String?
    let uploadedAt: String
    let hidden: Bool

    enum CodingKeys: String, CodingKey {
        case catID = "cat_id"
        case photourl = "photo"
        case photoDescription = "description"
        case uploadedAt = "uploaded_at"
        case hidden
    }
}

typealias Photos = [PhotoElement]


class NetworkManager : ServiceProtocol {
    
    func fetchCats(completion: @escaping ([Cat]?) -> Void) {
        loadDataByAlamofire(completion)
        //loadDataNormal(completion)
    }
    func fetchPhotos(completion: @escaping ([PhotoElement]?) -> Void) {
        loadPhotoByAlamofire(completion)
        //loadDataNormal(completion)
    }
    
    private func loadDataNormal(_ completion: @escaping ([Cat]?) -> Void) {
        guard let url = URL(string: "\(api_url_base)\(api_key)") else { return }
        //URLSession.setValue("Token \(User.current.token)", forHTTPHeaderField: "Authorization")
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
        let headers : HTTPHeaders = [
            "Authorization": "token \(User.current.token)"
        ]
        AF.request("\(api_url_base)\(api_key)",method: .get, headers: headers).responseJSON{ response in
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
    
    
    private func loadPhotoByAlamofire(_ completion: @escaping ([PhotoElement]?) -> Void) {
        let headers : HTTPHeaders = [
            "Authorization": "token \(User.current.token)"
        ]
        AF.request("https://cpcp-cats.herokuapp.com/api/photos/",method: .get, headers: headers).responseJSON{ response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
               // var datadict = ["results": data]
                guard let photos = try? JSONDecoder().decode(Photos.self, from: data) else {
                    completion(nil)
                    return
                }
                DispatchQueue.main.async {
                    completion(photos)
                }
        }
    }
    
}

