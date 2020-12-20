//
//  TruckLoadDTO.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 16.12.20.
//

import Foundation
struct TruckLoadDTO : Codable {
    let id : Int?
    let unitNumber : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case unitNumber = "unitNumber"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        unitNumber = try values.decodeIfPresent(String.self, forKey: .unitNumber)
    }

}
