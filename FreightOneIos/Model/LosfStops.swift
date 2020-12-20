//
//  LosfStops.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 16.12.20.
//

import Foundation
struct LoadStops : Codable {
    let loadStop : [LoadStop]?

    enum CodingKeys: String, CodingKey {

        case loadStop = "loadStop"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        loadStop = try values.decodeIfPresent([LoadStop].self, forKey: .loadStop)
    }

}
