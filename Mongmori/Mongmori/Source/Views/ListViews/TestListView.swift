//
//  TestListView.swift
//  Mongmori
//
//  Created by 지정훈 on 12/4/23.
//


import SwiftUI

struct TestListView: View {
    
    let input = """
    Day 1:
    오전: 협재해수욕장에서 아이와 해수욕을 즐깁니다.
    점심: 협재마을에 위치한 협재해장국 맛집에서 협재해장국을 맛보세요.
    오후: 성산일출봉을 방문하여 가족과 함께 하이킹을 즐길 수 있습니다.
    저녁: 섭지코지에 위치한 해물찜 맛집에서 맛있는 해물요리를 즐겨보세요.
    숙박: 섭지코지 일몰뷰가 멋진 해수욕장 호텔에서 숙박
    
    Day 2:
    오전: 우도를 방문하여 아이와 함께 자전거를 타고 우도의 아름다운 경치를 감상해주세요.
    점심: 우도에 위치한 해녀들의 식당에서 싱싱한 해산물을 제공하는 식사를 즐겨보세요.
    오후: 세계적으로 유명한 마라도를 방문하여 아이와 해변에서 즐거운 시간을 보낼 수 있습니다.
    저녁: 마라도 해수욕장 근처의 맛집에서 제주 특산물을 이용한 맛있는 음식을 맛보세요.
    숙박: 제주시에 위치한 편안한 가정집 개인 숙소에서 숙박
    """
    func parseDayPlans(input: String) -> [DayPlan] {
        var dayPlans: [DayPlan] = []
        
        let days = input.components(separatedBy: "\n\n")
        
        for (index, dayString) in days.enumerated() {
            let dayNumber = index + 1
            let activities = dayString.components(separatedBy: "\n")
            let dayPlan = DayPlan(day: dayNumber, activities: activities)
            dayPlans.append(dayPlan)
        }
        
        return dayPlans
    }
    
    
    @State var place: String = "애월"
    @State var duration: String = "3"
    
    @State var hegihtIndex: Int = 0
    
    
    @State private var currentDate: Date = Date()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var locationManager : LocationManager
    
    @State private var showLoading = true
    
    
    
    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0.0
    }
    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0.0
    }
    
    var body: some View {
        
        
        // 바꾸기
        if showLoading{
            LoadingView(place: $place, duration: $duration, showLoading: $showLoading)
                .navigationBarBackButtonHidden(true)
        }else{
            VStack {
                MapView(locationManager: LocationManager(), userLatitude: userLatitude, userLongitude: userLongitude)
                
                ScrollView{
                    ForEach(Array(parseDayPlans(input: input).enumerated()), id: \.element.day) { (index, dayPlan) in
                        
                        VStack{
                            HStack{
                                Text("day\(index+1)")
                                    .font(.poppins(.NanumSquareOTF_acEB, size: 18))
                                let currentDate = Calendar.current.date(byAdding: .day, value: index, to: currentDate) ?? currentDate //날짜 증가
                                
                                Text(Date().getFormattedTime(from: currentDate)+"/\(translationDay(str: Date().getDayOfWeek(from: currentDate)))")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.gray)
                                
                                Spacer()
                            }
                            .padding([.bottom,.top] ,12)
                            
                            HStack(alignment: .top){
                                ZStack {
                                    // 뒤에 선을 그린다
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 1, height: CGFloat(hegihtIndex) * 65)
                                        .zIndex(0)
                                        .offset(y: 40)
                                    
                                    Circle()
                                        .fill(randomColorCircle(index: index))
                                        .frame(width: 35, height: 35)
                                        .overlay {
                                            Text("\(index + 1)")
                                                .foregroundColor(.white)
                                                .zIndex(2)
                                        }
                                        .offset(y: -165)
                                        .zIndex(3)
                                }
                                
                                
                                VStack{
                                    ForEach(Array(dayPlan.activities.enumerated()), id: \.element) { (index, activity) in
                                        if index > 0{
                                            TestResultListView(index: index, str: activity)
                                                .onAppear{
                                                    hegihtIndex = dayPlan.activities.count
                                                }
                                        }
                                    }
                                }
                                
                                
                            }
                        }
                        
                    }
                    .padding([.leading,.trailing] ,24)
                    
                }
                // 전구뷰??
                
            }
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .padding(.top, 3)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("일정요약")
                    //                        .fontWeight(.bold)
                    //                        .font(.system(size: 20))
                        .font(.poppins(.NanumSquareOTF_acEB, size: 20))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("BackPageIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        
                    }
                }
                
            }
            
        }//
        
    }
    
}
//
#Preview {
    TestListView(place: "애월", duration: "3", locationManager: LocationManager())
}

func randomColorCircle(index: Int) -> Color{
    
    
    switch index{
    case 0:
        return Color.orange_500
    case 1:
        return Color.orange_100
    default:
        return Color.orange_50
    }
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
    case "Thursday":
        return "토"
    default:
        return "일"
    }
}
