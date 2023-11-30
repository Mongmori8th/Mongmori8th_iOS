//
//  MapView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//


import SwiftUI
import CoreLocation
import NMapsMap
import Combine
import UIKit

struct MapView: View {
    
    @ObservedObject var locationManager : LocationManager
    
    var userLatitude: Double
      
    var userLongitude: Double
      
  
    var body: some View {
        VStack{
//            ZStack(alignment: .center){
                UIMapView(locationManager: locationManager, userLatitude: userLatitude, userLongitude: userLongitude)
//                .padding([.leading,.trailing, .top] , 20)
//            }
        }.frame(width: Screen.maxWidth ,height: Screen.maxHeight * 0.3)
    }
}
struct UIMapView: UIViewRepresentable,View {
    
    @ObservedObject var viewModel = MapSceneViewModel()
    @ObservedObject var locationManager : LocationManager
    
    
    var userLatitude : Double
    var userLongitude : Double
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        // MARK: 네이버 맵 지도 생성
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        
        /// 숫자가 작을수록 축소 , 숫자가 클수록 확대
        view.mapView.zoomLevel = 12
        view.mapView.minZoomLevel = 10
        view.mapView.maxZoomLevel = 20
        view.mapView.isRotateGestureEnabled = false // 지도 회전 잠금
        
        // MARK: 네이버 지도 나침판, 현재 유저 위치 GPS 버튼
        view.showCompass = false
        // MARK: 위치 정보 받아오기
        view.showLocationButton = false

        view.mapView.touchDelegate = context.coordinator
        
        view.mapView.positionMode = .direction
        
        // MARK: 지도가 그려질때 현재 유저 GPS 위치로 카메라 움직임
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: userLatitude, lng: userLongitude))
        view.mapView.moveCamera(cameraUpdate)
        

        
        return view
    }
    
    // UIView 자체를 업데이트 해야 하는 변경이 swiftui 뷰에서 생길떄 마다 호출된다.
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        //임시
        return Coordinator(viewModel: self.viewModel)
    }
    
    
    
}
// 이벤트에 반응해야 하는 뷰들은 코디네이터 구현 해야함
class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
    // 임시
    @ObservedObject var viewModel: MapSceneViewModel
    @Published var latitude : Double
    @Published var longitude : Double
    @Published var point : CGPoint
    
    init(viewModel: MapSceneViewModel) {
        self.viewModel = viewModel
        self.latitude = 0.0
        self.longitude = 0.0
        self.point = CGPoint(x: 0, y: 0)
    }
    //     잠시
    var cancellable = Set<AnyCancellable>()
    
    // MARK: 터치 했을때 실행
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        // 임시
        self.latitude = latlng.lat
        self.longitude = latlng.lng
        self.point = point
    }
    
}

class MapSceneViewModel: ObservableObject {
    
}
