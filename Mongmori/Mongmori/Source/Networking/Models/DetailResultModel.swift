//
//  DetailResultModel.swift
//  Mongmori
//
//  Created by 지정훈 on 12/7/23.
//

import Foundation

struct JejuSpot : Identifiable,Codable,Hashable{
    let id = UUID()
    let name: String?
    let lat: Double?
    let lon: Double?
    let url: String?
    let phoneNumber: String?
    let address: String?
    let introduction: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, lat, lon, url, introduction
        case phoneNumber = "phone_number"
        case address
    }
}
