//
//  CatLists.swift
//  transitions mental health assoc
//
//  Created by Jillian Quinn on 5/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import Foundation

struct CatList: Decodable {
  //  var num: Int
    var results: [Cat]
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case results = ""
    }
}
