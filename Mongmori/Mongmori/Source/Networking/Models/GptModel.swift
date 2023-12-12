//
//  GptModel.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

// MARK: - GPT 전체 응답 값
    
struct TourResponse: Decodable,Hashable {
    let response: String
}

// MARK: - GPT 응답 값 문자별로 나누기

struct DayPlan: Hashable {
    var day: Int
    var activities: [String]
    var place: [String]
}
