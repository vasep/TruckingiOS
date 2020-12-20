//
//  LoadsForDriver.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 16.12.20.
//

import Foundation

struct LoadsForDriver: Codable {
    let count: Int
    let genericModel: [GenericModel]
    private enum CodingKeys: String, CodingKey {
            case count = "count", genericModel = "genericModel"
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        genericModel = try container.decode([GenericModel].self, forKey: .genericModel)
     }
}
