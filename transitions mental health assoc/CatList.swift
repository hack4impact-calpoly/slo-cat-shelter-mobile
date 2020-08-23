//
//  CatLists.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 5/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import Foundation

struct CatList: Decodable {
    var results: [Cat]
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case results = ""
    }
}
