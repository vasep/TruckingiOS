//
//  LoadCustomerDTO.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 16.12.20.
//

import Foundation

struct LoadCustomerDTO: Codable {
    let id : Int?
    let customerType : String?
    let companyName : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case customerType = "customerType"
        case companyName = "companyName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
    }

}
