//
//  Event.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 7/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import Foundation
 struct Event: Decodable, Identifiable, Hashable {
    let id: Int?
    let catID, eventType, title, date: String
    let time: String
    let notes: String?

     enum CodingKeys: String, CodingKey, CaseIterable, Codable, Hashable {
         case id
         case catID = "cat_id"
         case eventType = "event_type"
         case title, date, time, notes
     }
 }

 typealias Events = [Event]

