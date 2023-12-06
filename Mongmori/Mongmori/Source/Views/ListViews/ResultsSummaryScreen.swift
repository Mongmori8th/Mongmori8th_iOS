//
//  ResultsSummaryScreen.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//


// MARK: - AI Results Summary Screen ( AI 챗봇 결과에서 넘어오는 요약 뷰 )

import SwiftUI

struct DayPlan: Hashable {
    var day: Int
    var activities: [String]
    
    init(day: Int, activities: [String]) {
        self.day = day
        self.activities = activities
    }
}


struct ResultsSummaryScreen: View {
    
    @Binding var place: String
    @Binding var duration: String
    
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
        
        if false{ //고치기
            //        if showLoading{ //고치기
            LoadingView(place: $place, duration: $duration, showLoading: $showLoading)
                .navigationBarBackButtonHidden(true)
        }else{
            VStack {
                MapView(locationManager: LocationManager(), userLatitude: userLatitude, userLongitude: userLongitude)
                
                ScrollView{
                    
                    ForEach(Array(parseDayPlans(input: input).enumerated()), id: \.element.day) { (index, dayPlan) in
                        VStack(alignment: .leading){
                            if index == 0 {
                                Text("Day \(index+1) : 애월해안도로와 애월 바다마을")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .offset(x: 5, y: -10)
                            }else{
                                Text("Day \(index+1) : 자연 속 자전거 타기, 노래 부르기")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .offset(x: 5, y: -10)
                            }
                            
                            ForEach(Array(dayPlan.activities.enumerated()), id: \.element) { (index, activity) in
                                if index == 0{
                                    
                                }else{
                                    ResultListView(index: index, str: activity)
                                        .padding(.bottom , 15)
                                }
                            }
                            
                        }.padding()
                    }
                    
                    
                    
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.lightGray2)
                        .frame(width: Screen.maxWidth * 0.8, height: Screen.maxHeight * 0.15)
                        .overlay {
                            VStack(){
                                HStack{
                                    Image("LightOn")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Spacer()
                                }
                                .padding(.bottom, 12)
                                
                                Text("이렇게 거리 순서와 함께 넘버링된 일정을 참고 하여 즐거운 여행되시길 바랍니다!")
                                    .font(.poppins(.Pretendard_Bold, size: 16))
                            }
                            .padding(
                                EdgeInsets(
                                    top: 10,
                                    leading: 16,
                                    bottom: 10,
                                    trailing: 16
                                )
                            )
                        }
                        .padding(
                            EdgeInsets(
                                top: 10,
                                leading: 24,
                                bottom: 0,
                                trailing: 24
                            )
                        )
                    
                    
                    
                    
                    
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
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("BackPageIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        
                    }
                }
                
            }
            
        }
        
    }
    
}

//#Preview {
//    ResultsSummaryScreen(place: "애월", duration: "3", presentationMode: Binding<PresentationMode>, locationManager: LocationManager(), showLoading: false)
//}
