//
//  TestPageView.swift
//  Mongmori
//
//  Created by 지정훈 on 12/12/23.
//

import SwiftUI
import WebKit

struct NaverNaviView: View {
    @ObservedObject var locationManager : LocationManager
    
    var endLat: Double
    var endLon: Double
    var place: String
    
    var body: some View {
        VStack{
            WebView(urlString: "nmap://route/public?slat=\(locationManager.lastLocation?.coordinate.latitude ?? 0.0)&slng=\(locationManager.lastLocation?.coordinate.longitude ?? 0.0)&sname=현재 위치&dlat=\(endLat)&dlng=\(endLon)&dname=\(place)&appname=com.Mongmori.Mongmori")
        }
    }
}

//#Preview {
//    NaverNaviView()
//}

