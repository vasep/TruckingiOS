//
//  SingleLoads.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 16.12.20.
//

import Foundation

struct SingleLoads: Codable {
    let id: Int
    let customer: LoadCustomerDTO?
    let customerLoad: String?
    let loadStatus: String?
    let freightRate, temperature: Double?
    let truck: TruckLoadDTO?
    let driver, driver2: DriverTruckDTO?
    let trailer: EquipmentTruckDTO?
    let emptyMiles, loadedMiles: Double?
    let loadStops: LoadStops?

    private enum CodingKeys: String, CodingKey {
        case id = "id", customer = "customer",customerLoad = "customerLoad",
             loadStatus = "loadStatus", freightRate = "freightRate",temperature = "temperature",
             truck = "truck", driver = "driver",driver2 = "driver2",
             trailer = "trailer", emptyMiles = "emptyMiles",loadStops = "loadStops",loadedMiles="loadedMiles"
        }
    
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       id = try container.decode(Int.self, forKey: .id)
       customer = try container.decode(LoadCustomerDTO?.self, forKey: .customer)
       customerLoad = try container.decode(String?.self, forKey: .customerLoad)
       loadStatus = try container.decode(String?.self, forKey: .loadStatus)
       freightRate = try container.decode(Double?.self, forKey: .freightRate)
       truck = try container.decode(TruckLoadDTO?.self, forKey: .truck)
       temperature = try container.decode(Double?.self, forKey: .temperature)
       driver = try container.decode(DriverTruckDTO?.self, forKey: .driver)
       driver2 = try container.decode(DriverTruckDTO?.self, forKey: .driver2)
       trailer = try container.decode(EquipmentTruckDTO?.self, forKey: .trailer)
       emptyMiles = try container.decode(Double?.self, forKey: .emptyMiles)
       loadedMiles = try container.decode(Double?.self, forKey: .loadedMiles)
       loadStops = try container.decode(LoadStops?.self, forKey: .loadStops)
    }
}
