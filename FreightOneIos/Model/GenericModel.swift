//
//  GenericModel.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 16.12.20.
//

import Foundation

struct GenericModel: Codable {
    let id: Int
    private enum CodingKeys: String, CodingKey {
        case id = "id"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        
    }
}
