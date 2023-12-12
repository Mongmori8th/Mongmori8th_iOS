//
//  ChatViewModel.swift
//  Mongmori
//
//  Created by 지정훈 on 12/5/23.
//

import Foundation
import SwiftUI
import Alamofire
import Combine


final class ChatViewModel: ObservableObject {
    
    @Published var tourResponse: TourResponse?
    
    private var cancellables = Set<AnyCancellable>()

    
    func fetchGPTData(place: String, duration: String) -> Bool{
        let address = Bundle.main.infoDictionary?["GPTDataURL"] as! String

        let requestURL = "https://" + address + place + "&days=" + duration

        guard let url = URL(string: requestURL) else { return false }

        AF.request(url)
            .validate()
            .publishDecodable(type: TourResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.tourResponse = response.value
            })
            .store(in: &cancellables)
        
        return true
    }
    
    func sendErrorMessage(messages: [Message]) -> [Message]{
        var tmpMessages = messages
        tmpMessages.append(Message(sender: "몽모리", content: "작성해주신 형식이 올바르지 않아서 일정을 추천해 드리지 못했어요. 다시 한 번 장소와 날짜를 정확히 입력해 주세요! \n\n예시: '애월로 3일 동안', '제주시로 5일간'처럼 구체적으로 적어주시면 더욱 정확한 여행 일정을 추천해 드릴게요!", image: "Mongri"))
        return tmpMessages
    }
    
    func sendMessage(messages: [Message], newMessage: String, place: String, duration: String) -> ([Message],String) {
        var tmpMessages = messages
        var tmpNewMessages = newMessage
        
        if !tmpMessages.isEmpty {
            tmpMessages.append(Message(sender: "", content: tmpNewMessages, image: " "))
            
            if fetchGPTData(place: place, duration: duration){ // 통신 단계 고치기
                tmpMessages.append(Message(sender: "몽모리", content: "str", image: "Mongri", button: true))
            }
            
            tmpNewMessages = ""
            
        }
        return (tmpMessages,tmpNewMessages)
    }
    
    func minHeight(count: Int, messages: [Message]) -> CGFloat {
        let contentHeight = CGFloat(messages.count) * 110
        return min(contentHeight, 600)
    }
    
    func parseTourResponse(data: TourResponse) -> [DayPlan]{
        var dayPlans: [DayPlan] = []
        var currentDayNumber = 0
        var currentDayActivities: [String] = []
        var currentPlace: [String] = []
    
        let lines = data.response.components(separatedBy: "\n").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }


        for line in lines {
            if line.hasPrefix("Day") {

                if currentDayNumber >= 0 {
                    let dayPlan = DayPlan(day: currentDayNumber, activities: currentDayActivities, place: currentPlace)
                    currentDayNumber += 1
                    dayPlans.append(dayPlan)
                    currentDayActivities = []
                    currentPlace = []
                }

                if let dayNumberString = line.components(separatedBy: " ").last, let dayNumber = Int(dayNumberString) {
                    currentDayNumber = dayNumber
                }
            } else {
                let components = line.components(separatedBy: ":").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                if components.count == 2 {
                    currentDayActivities.append("\(components[0]) - \(components[1])")
                    currentPlace.append(components[1])
                }
            }
        }

        
        if currentDayNumber > 0 {
            let dayPlan = DayPlan(day: currentDayNumber, activities: currentDayActivities, place: currentPlace)
            dayPlans.append(dayPlan)
        }
        
        return dayPlans
    }
    

}
