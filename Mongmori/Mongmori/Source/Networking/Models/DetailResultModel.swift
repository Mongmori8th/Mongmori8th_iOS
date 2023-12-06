//
//  DetailResultModel.swift
//  Mongmori
//
//  Created by 지정훈 on 12/7/23.
//

import Foundation

struct DetailResultModel: Codable,Hashable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable,Hashable{
    let name, lat, lon, placeURL: String
    let phonNumber, address: String
}
