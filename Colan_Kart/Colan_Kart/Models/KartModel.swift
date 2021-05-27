//
//  KartModel.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import Foundation

struct KartModel: Codable {
    let status:String?
    let data: [KartData]?
}

struct KartData: Codable {
    let id: Int?
    let storage_name: String?
    let quantity: Int?
}
