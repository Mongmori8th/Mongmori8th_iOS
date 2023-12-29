//
//  SelectModalView.swift
//  Mongmori
//
//  Created by 지정훈 on 12/29/23.
//

import SwiftUI
import MapKit

struct SelectModalView: View {
    @State var isShowSheetNaver: Bool = false
    
    
    @ObservedObject var locationManager : LocationManager
    
    var endLat : Double
    var endLon : Double
    
    @Binding var place : String
    
    var body: some View {
        VStack{

            Text("AI 몽모리가 위치를 안내해 드릴게요")
                .font(.poppins(.NanumSquareOTF_acEB, size: 18))
                .padding(
                    EdgeInsets(
                        top: 24,
                        leading: 16,
                        bottom: 16,
                        trailing: 24
                    )
                )
            
            HStack(alignment: .center){
                VStack{
                    Image("naverIconApp")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45,height: 45)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                    
                    Text("네이버 지도")
                        .font(.poppins(.NanumSquareOTF_acEB, size: 14))
                        .lineSpacing(5)
                        .padding(.top, 20)
                }
                .padding(.trailing, 40)
                .onTapGesture {
                    isShowSheetNaver.toggle()
                }
                
                VStack{
                    Image("appleIconApp")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45,height: 45)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
   
                    Text("애플 지도")
                        .font(.poppins(.NanumSquareOTF_acEB, size: 14))
                        .lineSpacing(5)
                        .padding(.top, 20)
                    
                    
                }
                .padding(.leading, 40)
                .onTapGesture {
                    startNavigation()
                }
            }
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 16,
                    bottom: 16,
                    trailing: 24
                )
            )
            
        }
        .sheet(isPresented: $isShowSheetNaver) {
            NaverNaviView(locationManager: locationManager, endLat: endLat, endLon: endLon, place: place)
                .presentationDetents([.large])
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        isShowSheetNaver = false
                    }
                }
        }
    }
    
    private func startNavigation() {
  
        let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: locationManager.lastLocation?.coordinate.latitude ?? 0.0, longitude: locationManager.lastLocation?.coordinate.longitude ?? 0.0))
        let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: endLat, longitude: endLon))

        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        sourceItem.name = "현재위치"
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        destinationItem.name = place
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]

        MKMapItem.openMaps(with: [sourceItem, destinationItem], launchOptions: launchOptions)
    }
}
//
//#Preview {
//    SelectModalView()
//}
