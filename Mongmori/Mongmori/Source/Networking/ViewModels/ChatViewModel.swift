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
        tmpMessages.append(Message(sender: "몽모리", content: "작성해 주신 형식이 올바르지 않아서 일정을 추천해 드리지 못했어요..! 다시 한번 장소와 날짜를 정확히 입력해 주세요! \n\n예시:\n'애월로 12월 17일부터 12월 19일까지',\n'제주시로 1월 3일부터 1월 6일까지'\n'지역'로 '기간'일로 작성해주시면  더욱 정확한 여행 일정을 추천해 드릴게요!", image: "Mongri"))
        return tmpMessages
    }
    
    func sendMessage(messages: [Message], newMessage: String, place: String, duration: String) -> ([Message],String) {
        var tmpMessages = messages
        var tmpNewMessages = newMessage
        
        if !tmpMessages.isEmpty {
            tmpMessages.append(Message(sender: "", content: tmpNewMessages, image: " "))
            
            if fetchGPTData(place: place, duration: duration){
                tmpMessages.append(Message(sender: "몽모리", content: "str", image: "Mongri", button: true))
            }
            
            tmpNewMessages = ""
            
        }
        return (tmpMessages,tmpNewMessages)
    }
    
    func minHeight(count: Int, messages: [Message]) -> CGFloat {
        let contentHeight = CGFloat(messages.count) * 140
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
                    
                    let resultString = components[1].replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
                    
                    currentDayActivities.append("\(components[0]) - \(resultString)")
                    currentPlace.append(resultString)

                }
            }
        }

        
        if currentDayNumber > 0 {
            let dayPlan = DayPlan(day: currentDayNumber, activities: currentDayActivities, place: currentPlace)
            dayPlans.append(dayPlan)
        }
        
        return dayPlans
    }

    
    func translationDay(str: String) -> String{
        switch str{
        case "Monday":
            return "월"
        case "Tuesday":
            return "화"
        case "Wednesday":
            return "수"
        case "Thursday":
            return "목"
        case "Friday":
            return "금"
        case "Saturday":
            return "토"
        default:
            return "일"
        }
    }
    
    func translationDate(date: Date, increase: Int) -> String{
        let increasingDate = date.addingTimeInterval(TimeInterval(((+24 * 60 * 60) * increase)))
        let formattedDate = getFormattedDate(from: increasingDate)
        
        let dayKR = translationDay(str: getDayOfWeek(from: increasingDate.addingTimeInterval(-24 * 60 * 60)))
//        let dayKR = translationDay(str: getDayOfWeek(from: increasingDate))
        return formattedDate + "/" + dayKR
    }
    
    func getFormattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: date)
    }
    
    func getDayOfWeek(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }

    
    


}

