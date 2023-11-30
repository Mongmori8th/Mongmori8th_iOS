//
//  ResultsSummaryScreen.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//


// MARK: - AI Results Summary Screen ( AI 챗봇 결과에서 넘어오는 요약 뷰 )

import SwiftUI

struct ResultsSummaryScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var locationManager : LocationManager
    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0.0
    }
    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0.0
    }
    
    var body: some View {
            
            VStack {
                MapView(locationManager: LocationManager(), userLatitude: userLatitude, userLongitude: userLongitude)
                
                ScrollView{
                    ForEach(1..<3) { index in
                        VStack(alignment: .leading){
                            
                            Text("Day\(index): 애월해안도로와 애월바다 마을")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            
                            ForEach(1..<6) { index in
                                ResultListView(index: index)
                            }
    
                        }.padding()
                    }

                    
                }
                // 전구뷰??
                
            }
            .background(Color.orange_100)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .padding(.top, 3)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("일정요약")
                        .font(.title2.bold())
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("BackPageIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            
                    }
                }
                
            }
            
        
        
        
    }
    
}
//
#Preview {
    ResultsSummaryScreen(locationManager: LocationManager())
}
