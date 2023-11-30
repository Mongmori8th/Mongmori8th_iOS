////
////  PromptTestView.swift
////  Mongmori
////
////  Created by 지정훈 on 11/30/23.
////
//
//import SwiftUI
//
//struct DayPlan {
//    var day: Int
//    var activities: [String]
//
//    init(day: Int, activities: [String]) {
//        self.day = day
//        self.activities = activities
//    }
//}
//
//struct PromptTestView: View {
//    let input = """
//    Day 1:
//    오전: 협재해수욕장에서 아이와 해수욕을 즐깁니다.
//    점심: 협재마을에 위치한 협재해장국 맛집에서 협재해장국을 맛보세요.
//    오후: 성산일출봉을 방문하여 가족과 함께 하이킹을 즐길 수 있습니다.
//    저녁: 섭지코지에 위치한 해물찜 맛집에서 맛있는 해물요리를 즐겨보세요.
//    숙박: 섭지코지 일몰뷰가 멋진 해수욕장 호텔에서 숙박
//
//    Day 2:
//    오전: 우도를 방문하여 아이와 함께 자전거를 타고 우도의 아름다운 경치를 감상해주세요.
//    점심: 우도에 위치한 해녀들의 식당에서 싱싱한 해산물을 제공하는 식사를 즐겨보세요.
//    오후: 세계적으로 유명한 마라도를 방문하여 아이와 해변에서 즐거운 시간을 보낼 수 있습니다.
//    저녁: 마라도 해수욕장 근처의 맛집에서 제주 특산물을 이용한 맛있는 음식을 맛보세요.
//    숙박: 제주시에 위치한 편안한 가정집 개인 숙소에서 숙박
//    """
//    
//    func parseDayPlans(input: String) -> [DayPlan] {
//        var dayPlans: [DayPlan] = []
//
//        let days = input.components(separatedBy: "\n\n")
//
//        for (index, dayString) in days.enumerated() {
//            let dayNumber = index + 1
//            let activities = dayString.components(separatedBy: "\n")
//            let dayPlan = DayPlan(day: dayNumber, activities: activities)
//            dayPlans.append(dayPlan)
//        }
//
//        return dayPlans
//    }
//
//    var body: some View {
//        List(parseDayPlans(input: input), id: \.day) { dayPlan in
//            VStack(alignment: .leading, spacing: 10) {
//                ForEach(dayPlan.activities, id: \.self) { activity in
//                    Text(activity)
//                }
//            }
//            .padding()
//            .background(Color.gray.opacity(0.1))
//            .cornerRadius(10)
//            .padding(.vertical, 5)
//        }
//        .navigationBarTitle("Jeju Island Itinerary", displayMode: .inline)
//    }
//        
//}
//
//#Preview {
//    PromptTestView()
//}
//
//
//
//

