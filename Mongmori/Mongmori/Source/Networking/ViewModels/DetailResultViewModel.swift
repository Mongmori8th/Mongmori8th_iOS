//
//  DetailResultViewModel.swift
//  Mongmori
//
//  Created by 지정훈 on 12/7/23.
//

import Foundation
import UIKit
import KakaoSDKNavi

final class DetailResultViewModel: ObservableObject {
    
    // MARK: - 전화번호

    func callButtonTapped(number: String){
        let tmp = number
        let telephone = "tel://"
        let formattedString = telephone + tmp
        //        let formattedString = telephone + numberString
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
        print("url:\(url)")
        
    }
    
    // MARK: - 카카오네비

    func kakaoNavi(){
        let title = "1"
        let longitutde = 126.9425
        let latitude = 33.458056
        
        let destination = NaviLocation(name: title, x: String(longitutde), y: String(latitude))
        let option = NaviOption(coordType: .WGS84)
        
        guard let shareUrl = NaviApi.shared.shareUrl(destination: destination, option: option) else {
            return
        }
        
        UIApplication.shared.open(shareUrl, options: [:], completionHandler: nil)
        
    }
    
    func testJson(jsonString: String) -> DetailResultModel{
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let testJSON = try JSONDecoder().decode(DetailResultModel.self, from: jsonData)
                return testJSON
                
            }
            catch {
                print("디코딩 에러: \(error)")
            }
        }
        return DetailResultModel(data: [Datum(name: "", lat: "", lon: "", placeURL: "", phonNumber: "", address: "")])
    }

    
}

