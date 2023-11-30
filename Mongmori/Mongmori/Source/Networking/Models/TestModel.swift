//
//  TestModel.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

import Foundation
import Combine
import SwiftUI
import Alamofire

class PromptViewModel{
    var resultString: String = ""

    func fetchDataWithAlamofire(location: String, days: String, completion: @escaping (String?) -> Void) {
        // URL 생성
        let url = "http://13.209.49.103:8000/gpt-prompt/?location=\(location)&days=\(days)"
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ResponseModel.self, from: response.data!)
                    print(type(of: result.response))
                    self.resultString = result.response
                    completion(self.resultString)
                } catch {
                    print("JSON Decoding Error: \(error.localizedDescription)")
                    completion(nil)
                }
                
            case .failure(let error):
                // 오류 처리
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

}


