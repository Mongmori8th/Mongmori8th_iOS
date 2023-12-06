//
//  DirectionsModel.swift
//  Mongmori
//
//  Created by 지정훈 on 12/6/23.
//

import Foundation

struct Search: Codable {
    let code: Int
    let message, currentDateTime: String
    let route: Route
}

struct Route: Codable {
    let trafast: [Trafast]
}

struct Trafast: Codable {
    let summary: Summary
    let path: [[Double]]
    let section: [Section]
    let guide: [Guide]
}

struct Guide: Codable {
    let pointIndex, type: Int
    let instructions: String
    let distance, duration: Int
}


struct Section: Codable {
    let pointIndex, pointCount, distance: Int
    let name: String
    let congestion, speed: Int
}

struct Summary: Codable {
    let start: Start
    let goal: Goal
    let distance, duration, etaServiceType: Int
    let departureTime: String
    let bbox: [[Double]]
    let tollFare, taxiFare, fuelPrice: Int
}


struct Goal: Codable {
    let location: [Double]
    let dir: Int
}

struct Start: Codable {
    let location: [Double]
}
