//
//  MongmoriApp.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

import SwiftUI

@main
struct MongmoriApp: App {
    var body: some Scene {
        WindowGroup {
            MapView(locationManager: LocationManager())
        }
    }
}
