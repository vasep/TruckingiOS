//
//  LoadStop.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 16.12.20.
//

import Foundation
struct LoadStop : Codable {
    let id : String?
    let stopType : String?
    let dateTime : String?
    let appNr : String?
    let puNr : String?
    let refNr : String?
    let bol : String?
    let company : String?
    let contact : String?
    let street : String?
    let city : String?
    let state : String?
    let zip : String?
    let comment : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case stopType = "stopType"
        case dateTime = "dateTime"
        case appNr = "appNr"
        case puNr = "puNr"
        case refNr = "refNr"
        case bol = "bol"
        case company = "company"
        case contact = "contact"
        case street = "street"
        case city = "city"
        case state = "state"
        case zip = "zip"
        case comment = "comment"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        stopType = try values.decodeIfPresent(String.self, forKey: .stopType)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        appNr = try values.decodeIfPresent(String.self, forKey: .appNr)
        puNr = try values.decodeIfPresent(String.self, forKey: .puNr)
        refNr = try values.decodeIfPresent(String.self, forKey: .refNr)
        bol = try values.decodeIfPresent(String.self, forKey: .bol)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        contact = try values.decodeIfPresent(String.self, forKey: .contact)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
