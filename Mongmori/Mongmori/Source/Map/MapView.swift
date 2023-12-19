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
      
    let jejuSpot : [JejuSpot]
    
    @Binding var isShowingPhotoSpotMapVIew: Bool // 주변 게시물 보여주는 Bool
    @Binding var modalPlace: String
    @Binding var modalLat: Double
    @Binding var modalLon: Double
    @Binding var responsePlace : Set<String>
    
    var body: some View {
        VStack{
            UIMapView(locationManager: locationManager, userLatitude: userLatitude, userLongitude: userLongitude, jejuSpot: jejuSpot, responsePlace: $responsePlace, isShowingPhotoSpotMapVIew: $isShowingPhotoSpotMapVIew, modalPlace: $modalPlace, modalLat: $modalLat, modalLon: $modalLon)
        }.frame(width: Screen.maxWidth ,height: Screen.maxHeight * 0.3)
    }
}
struct UIMapView: UIViewRepresentable,View {
    
    @ObservedObject var viewModel = MapSceneViewModel()
    @ObservedObject var locationManager : LocationManager

    var userLatitude : Double
    var userLongitude : Double
    
    let jejuSpot : [JejuSpot]
    
    @State var markerList: [NMFMarker] = []
    @Binding var responsePlace : Set<String>
    @Binding var isShowingPhotoSpotMapVIew: Bool    //모달뷰
    @Binding var modalPlace: String
    @Binding var modalLat: Double
    @Binding var modalLon: Double
    
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        
        
        view.mapView.zoomLevel = 8
        view.mapView.minZoomLevel = 2
        view.mapView.maxZoomLevel = 20
        view.mapView.isRotateGestureEnabled = false
        
        
        view.showCompass = false
        view.showLocationButton = false
        view.showZoomControls = true
            
        view.mapView.touchDelegate = context.coordinator
        
        view.mapView.positionMode = .direction
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 33.3846216, lng: 126.5534925))
        view.mapView.moveCamera(cameraUpdate)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            for i in responsePlace{
                for j in jejuSpot{
                    if j.name == i{
                        let marker = NMFMarker(position: NMGLatLng(lat: j.lat ?? 0.0 , lng: j.lon ?? 0.0))
//                        marker.iconImage = NMFOverlayImage(name: "mapPinOrangeFill")
                        marker.iconImage = NMFOverlayImage(name: "allMarker")
                        marker.width = 30
                        marker.height = 30
                        marker.captionText = j.name ?? ""
                        marker.captionColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                        marker.captionTextSize = 7
                        marker.captionHaloColor = UIColor(.white)
                        markerList.append(marker)
//                        marker.mapView = view.mapView
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            for marker in markerList{
                marker.mapView = view.mapView
                
                marker.touchHandler = { (overlay) in
                    if let marker = overlay as? NMFMarker {
                        modalPlace = marker.captionText
                        modalLat = marker.position.lat
                        modalLon = marker.position.lng
                        isShowingPhotoSpotMapVIew = true
                    }
                    return true
                }
            }
        }
        
            
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: self.viewModel)
    }
    
    
    
}

class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {

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
   
    var cancellable = Set<AnyCancellable>()
    
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
    }
    
}

class MapSceneViewModel: ObservableObject {
    
}
