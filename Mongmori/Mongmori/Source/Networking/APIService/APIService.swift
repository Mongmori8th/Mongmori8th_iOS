//
//  APIService.swift
//  Mongmori
//
//  Created by 지정훈 on 12/6/23.
//

import Foundation
import Alamofire
import Combine


// MARK: - 네이버 Directions 5 API 사용 -> 사용자 위치부터 목적지까지의 거리 구하기
final class APIService : ObservableObject{
    
    @Published var directionsResult: Search?
    @Published var resultDistance: String?
    
    
    
    var fetchDirectionsSuccess = PassthroughSubject<Void, Never>()
    var subscription = Set<AnyCancellable>()
    
    // MARK: - 사용자 목적지 받아서 API 요청 받기
    func fetchNaverAPIDirections(startLocation: (Double, Double), endLocation: (Double, Double)) {
        let start = "\(startLocation.0),\(startLocation.1)"
        let goal = "\(endLocation.0),\(endLocation.1)"
        
        let parameters: [String: Any] = [
            "start": start,
            "goal": goal,
            "option": "trafast"
        ]
        
        let headers: HTTPHeaders = [
            NaverAPIEnum.naverApI.clientHeaderKeyID : Bundle.main.infoDictionary?["NaverClientID"] as! String,      //clientID
            NaverAPIEnum.naverApI.clientHeaderSecretID: Bundle.main.infoDictionary?["NaverClientSecret"] as! String     //clientSecret
        ]
        
        
        let request = AF.request("https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving", method: .get, parameters: parameters, headers: headers)
        
        debugPrint(request)
        
        request.validate()
            .responseDecodable(of: Search.self) { response in

                switch response.result {
                case .success(let data):
                    self.directionsResult = data
                    self.objectWillChange.send()
//                    print(data.route.trafast[0].summary.duration)
                    self.resultDistance = self.getDistance(meters: data.route.trafast[0].summary.distance)
                    self.fetchDirectionsSuccess.send()
                    print(#function)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
    
    func getDistance(meters: Int) -> String{
        let result = String((meters / 1000))
        return result
    }
   
    
}

enum NaverAPIEnum {
    case naverApI
    // MARK: 네이버 클라우드 플랫폼 Client ID
    var clientHeaderKeyID: String {
        switch self {
        case .naverApI: return "X-NCP-APIGW-API-KEY-ID"
        }
    }
    // MARK: 네이버 클라우드 플랫폼 Client Secret
    var clientHeaderSecretID: String {
        switch self {
        case .naverApI: return "X-NCP-APIGW-API-KEY"
        }
    }
}

