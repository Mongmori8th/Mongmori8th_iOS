//
//  DetailResultViewModel.swift
//  Mongmori
//
//  Created by 지정훈 on 12/7/23.
//

import Foundation
import UIKit
import Combine
import Alamofire
import WebKit

final class DetailResultViewModel: ObservableObject {
    
    @Published var jejuTourList: [JejuSpot] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - 전화번호
    
    func callButtonTapped(number: String){
        if number != nil{
            let tmp = number
            let telephone = "tel://"
            let formattedString = telephone + tmp
            //        let formattedString = telephone + numberString
            guard let url = URL(string: formattedString) else { return }
            UIApplication.shared.open(url)
        }else{
            let formattedString = "전화번호 정보가 없습니다."
            guard let url = URL(string: formattedString) else { return }
            UIApplication.shared.open(url)
        }
        
        
        
    }

    func fetchJsonData() {
        
        let address = Bundle.main.infoDictionary?["JsonDataURL"] as! String
        let requestURL = "http://" + address + "//api/jeju-tourist-spots/?format=json"
        
        guard let url = URL(string: requestURL) else { return }
        
        AF.request(url)
            .publishDecodable(type: [JejuSpot].self)
            .sink(receiveCompletion: { _ in }) { response in
                if let jejuTourList = response.value {
                    self.jejuTourList = jejuTourList
                }
            }
            .store(in: &cancellables)
    }
}

