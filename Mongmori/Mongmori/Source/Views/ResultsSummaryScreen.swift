//
//  ResultsSummaryScreen.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//


// MARK: - AI Results Summary Screen ( AI 챗봇 결과에서 넘어오는 요약 뷰 )

import SwiftUI

struct ResultsSummaryScreen: View {
    @ObservedObject var locationManager : LocationManager
    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0.0
    }
    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0.0
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 2, height: 400)
                    .offset(x: 0, y: 210)
                    .zIndex(1) // Rectangle의 zIndex를 조절
                VStack {
                    MapView(locationManager: LocationManager(), userLatitude: userLatitude, userLongitude: userLongitude)
                        
                    HStack {
                        Text("AI 뭉니의 일정 요약")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.leading,10)
                        Spacer()
                    }
                    .padding(10)
                    
                    ScrollView{
                        ForEach(1..<3) { index in
                            VStack(alignment: .leading){
                                Text("Day\(index): ~~~~~~~~~")
                                    .fontWeight(.bold)
                                    .font(.system(size: 15))
                                    .offset(x:25, y:20)
                                ForEach(1..<6) { index in
                                    if index == 6 {
                                        Rectangle()
                                            .offset(x: 0, y: 0)
                                            .fill(Color.blue)
                                            .frame(width: 3, height: 400)
                                    }
                                    ResultListView(index: index)
                                        .offset(y: -5)
                                }
                                
                                
                            }
                            
                            
                          
                        }
                        
                    }
                    
                }
                .zIndex(2)
            }
        }
        
        
    }
    
}
//
//#Preview {
//    ResultsSummaryScreen()
//}
