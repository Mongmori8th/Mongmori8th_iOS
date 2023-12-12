//
//  ResultsSummaryScreen.swift
//  Mongmori
//
//  Created by 지정훈 on 12/4/23.
//


import SwiftUI
//
struct ResultsSummaryScreen: View {
    
    @Binding var place: String
    @Binding var duration: String
    
    @State var hegihtIndex: Int = 0
    
    
    @State private var currentDate: Date = Date()
    
    
    @StateObject var naverApiVM = APIService()
    @ObservedObject var chatVM : ChatViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var locationManager : LocationManager
    
    @State private var showLoading = true
    @State private var responsePlace: Set<String> = Set()
    
    
    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0.0
    }
    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0.0
    }
    
    var responseData : TourResponse
    let jejuSpot : [JejuSpot]
    
    
    var body: some View {
        
//         바꾸기
        if showLoading{
            LoadingView(place: $place, duration: $duration, showLoading: $showLoading)
                .navigationBarBackButtonHidden(true)
        }else{
            VStack {
                MapView(locationManager: locationManager, userLatitude: userLatitude, userLongitude: userLongitude, jejuSpot: jejuSpot, responsePlace: $responsePlace)
                
                ScrollView{
                    ForEach(Array(chatVM.parseTourResponse(data: responseData).enumerated()), id: \.element.day) { (index, dayPlan) in
                        if index == 0{
                            
                        }else{
                            VStack{
                                HStack{
                                    Text("Day\(dayPlan.day)")
                                        .font(.poppins(.NanumSquareOTF_acEB, size: 18))
                                    let currentDate = Calendar.current.date(byAdding: .day, value: index, to: currentDate) ?? currentDate //날짜 증가
                                    
                                    Text(Date().getFormattedTime(from: currentDate)+"/\(translationDay(str: Date().getDayOfWeek(from: currentDate)))")
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.gray)
                                    
                                    Spacer()
                                }
                                .padding([.bottom,.top] ,12)
                                
//                                HStack(alignment: .top){
//                                    ZStack {
//                                        // 뒤에 선을 그린다
//                                        Rectangle()
//                                            .fill(Color.gray)
//                                            .frame(width: 1, height: CGFloat(hegihtIndex) * 75)
//                                            .zIndex(0)
//                                            .offset(y: 40)
//                                        
//                                        Circle()
//                                            .fill(randomColorCircle(index: index))
//                                            .frame(width: 35, height: 35)
//                                            .overlay {
//                                                Text("\(index)")
//                                                    .foregroundColor(.white)
//                                                    .zIndex(2)
//                                            }
//                                            .offset(y: -165)
//                                            .zIndex(3)
//                                    }
                                    

                                    VStack{
                                        ForEach(Array(dayPlan.activities.enumerated()), id: \.element) { (index, activity) in
                                            ResultListView(index: index, str: activity, place: dayPlan.place[index], jejuSpot: jejuSpot, locationManager: locationManager)
                                                .onAppear{
                                                    hegihtIndex = dayPlan.activities.count
                                                    responsePlace.insert(dayPlan.place[index])
                                                }
                                        }
                                        
                                    }
                                    
                                    
                                    
//                                }
                                
                            }
                        }
                        
                    }
                    .padding([.leading,.trailing] ,24)
                    
                    // MARK: - 전구 뷰
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.lightGray2)
                        .frame(width: Screen.maxWidth * 0.8, height: Screen.maxHeight * 0.15)
                        .overlay {
                            VStack(){
                                HStack{
                                    Image("bulb")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                    Spacer()
                                }
                                .padding(.bottom, 12)
//                                Text("이렇게 거리 순서와 함께 넘버링된 일정을 참고 하여 즐거운 여행되시길 바랍니다!")
                                Text("AI 몽모리가 추천해 드린 다양한 관광지를 방문하고 현지 음식을 맛보며 즐거운 시간 보내길 바라며, 안전하게 여행을 마치고 아이와 함께 행복한 추억을 가지고 돌아오세요! ")
                                    .font(.poppins(.Pretendard_Bold, size: 14))
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
                        Image("arrowLeft")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        
                    }
                }
                
            }
            
        }//
        
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

