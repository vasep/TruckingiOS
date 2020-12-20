//
//  DriverTruckDTO.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 16.12.20.
//

import Foundation
struct DriverTruckDTO : Codable {
    let id : Int?
    let firstName : String?
    let lastName : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
    }
}
