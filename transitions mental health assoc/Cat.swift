/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual Patient.
*/

import Foundation
import SwiftUI
import Alamofire

struct Cat: Decodable, Identifiable, Hashable {
    var id: Int?
    let name: String
    let gender: Gender
    let age: Double
    let birthday, catDescription, breed: String
    let itype: Itype
    let status: Status
    let arrivalDate, arrivalDetails, medicalHistory, vaccinations: String
    let isMicrochipped: Bool
    let fleaControlDate, dewormingDate, fivFelvDate: String
    let specialNeeds: String?
    let personality: [Int]
    let morePersonality, comments: String?
    let personalExp: String?

    enum CodingKeys: String, CodingKey, CaseIterable, Codable, Hashable {
        case id, name, gender, age, birthday
        case catDescription = "description"
        case breed, itype, status
        case arrivalDate = "arrival_date"
        case arrivalDetails = "arrival_details"
        case medicalHistory = "medical_history"
        case vaccinations
        case isMicrochipped = "is_microchipped"
        case fleaControlDate = "flea_control_date"
        case dewormingDate = "deworming_date"
        case fivFelvDate = "fiv_felv_date"
        case specialNeeds = "special_needs"
        case personality
        case morePersonality = "more_personality"
        case comments
        case personalExp = "personal_exp"
    }
}

enum Gender: String, Codable {
    case m = "M"
    case f = "F"
}

enum Itype: String, Codable {
    case dmh = "DMH"
    case dsh = "DSH"
    case dlh = "DLH"
}

enum Status: String, Codable {
    case adopt = "adopt"
    case temporary = "temporary"
    case permanent = "permanent"
}
    

typealias CatList2 = [Cat]
