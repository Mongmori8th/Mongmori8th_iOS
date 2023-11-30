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
//    let list :[NMGLatLng] = [
//        NMGLatLng(lat:  33.4889673, lng: 126.4188189),
//        NMGLatLng(lat: 33.3899391, lng: 126.3663248),
//        NMGLatLng(lat: 33.4745416, lng: 126.354882),
//        NMGLatLng(lat: 33.4877605, lng: 126.3904307),
//        NMGLatLng(lat: 33.231847, lng: 126.314641),
//        
//        NMGLatLng(lat: 33.231847, lng: 126.314641),
//        NMGLatLng(lat: 33.4877605, lng: 126.354882)
//        ]
    
    
    
    var userLatitude : Double
    var userLongitude : Double
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        // MARK: 네이버 맵 지도 생성
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        
        /// 숫자가 작을수록 축소 , 숫자가 클수록 확대
        view.mapView.zoomLevel = 8
        view.mapView.minZoomLevel = 2
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
        
        let markerList: [NMFMarker] = [
            NMFMarker(position: NMGLatLng(lat: 33.4889673, lng: 126.4188189)),
            NMFMarker(position: NMGLatLng(lat:  33.389939, lng: 126.3663248)),
            NMFMarker(position: NMGLatLng(lat: 33.4745416, lng: 126.354882)),
            NMFMarker(position: NMGLatLng(lat: 33.4877605, lng: 126.3904307)),
            NMFMarker(position: NMGLatLng(lat:  33.231847, lng: 126.314641)),

            NMFMarker(position: NMGLatLng(lat: 33.2318473, lng: 126.314641))
//            NMFMarker(position: NMGLatLng(lat: 33.4877605, lng: 126.354882)),
            
        ]

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            for i in markerList{
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: i.position.lat, lng: i.position.lng)
                marker.iconImage = NMFOverlayImage(name: "heroicons_map-pin1")
                marker.width = 30
                marker.height = 30
                marker.mapView = view.mapView
            }
        }
        
        
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
