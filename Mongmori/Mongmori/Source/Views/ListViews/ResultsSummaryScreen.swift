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
    @Binding var currentDate: Date
    
    
    @State var hegihtIndex: Int = 0
    @State var textDate: Date = Date()
    
    @StateObject var naverApiVM = APIService()
    @ObservedObject var chatVM : ChatViewModel
    @ObservedObject var detailResultVM : DetailResultViewModel
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var locationManager : LocationManager
    
    @State private var showLoading = true
    @State private var responsePlace: Set<String> = Set()
    
    @State var isShowingPhotoSpotMapVIew: Bool = false // 주변 게시물 보여주는 Bool
    @State var modalPlace: String = ""
    @State var modalLat: Double = 0.0
    @State var modalLon: Double = 0.0
    
    @State var showAlert: Bool = false
    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0.0
    }
    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0.0
    }
    
    var responseData : TourResponse
    let jejuSpot : [JejuSpot]
    
    
    var body: some View {
        
        //                 바꾸기
        if showLoading{
            LoadingView(place: $place, duration: $duration, showLoading: $showLoading)
                .navigationBarBackButtonHidden(true)
        }else{
            VStack {
                MapView(locationManager: locationManager, userLatitude: userLatitude, userLongitude: userLongitude, jejuSpot: jejuSpot, isShowingPhotoSpotMapVIew: $isShowingPhotoSpotMapVIew,  modalPlace: $modalPlace, modalLat: $modalLat, modalLon: $modalLon, responsePlace: $responsePlace, showAlert: $showAlert)
                
                ScrollView{
                    ForEach(Array(chatVM.parseTourResponse(data: responseData).enumerated()), id: \.element.day) { (index, dayPlan) in
                        if index == 0{
                            
                        }else{
                            VStack{
                                HStack{
                                    Text("Day\(dayPlan.day)")
                                        .font(.poppins(.NanumSquareOTF_acEB, size: 18))
                                    //                                    .kerning(22)
                                        .lineSpacing(7)
                                    Text(chatVM.translationDate(date: currentDate, increase: dayPlan.day))
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.gray)
                                    
                                    Spacer()
                                }
                                .padding([.bottom,.top] ,12)
                                
                                VStack{
                                    ForEach(Array(dayPlan.activities.enumerated()), id: \.element) { (index, activity) in
                                        ResultListView(index: index, str: activity, place: dayPlan.place[index], jejuSpot: jejuSpot, locationManager: locationManager)
                                            .onAppear{
                                                hegihtIndex = dayPlan.activities.count
                                                responsePlace.insert(dayPlan.place[index])
                                            }
                                            .padding([.top] ,16)
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
                        .frame(width: Screen.maxWidth * 0.8, height: Screen.maxHeight * 0.22)
                        .overlay {
                            VStack(){
                                HStack{
                                    Image("bulb")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                    Spacer()
                                }
                                .padding(.bottom, 12)
                                //                                Text("이렇게 거리 순서와 함께 넘버링된 일정을 참고 하여 즐거운 여행되시길 바랍니다!")
                                Text("AI 몽모리가 추천해 드린 다양한 관광지를 방문하고 현지 음식을 맛보며 즐거운 시간 보내길 바라며, 안전하게 여행을 마치고 아이와 함께 행복한 추억을 가지고 돌아오세요! ")
                                    .font(.poppins(.Pretendard_Bold, size: 14))
                                    .lineSpacing(8)
                            }
                            .padding(
                                EdgeInsets(
                                    top: 16,
                                    leading: 16,
                                    bottom: 16,
                                    trailing: 16
                                )
                            )
                        }
                        .padding(
                            EdgeInsets(
                                top: 10,
                                leading: 24,
                                bottom: 10,
                                trailing: 24
                            )
                        )
                    
                }
                
                
                
            }
            .fullScreenCover(isPresented: $isShowingPhotoSpotMapVIew) {
                //                .sheet(isPresented: $isShowingPhotoSpotMapVIew) {
                NavigationView{
                    DetailResultListModalView(jejuSpot: jejuSpot, detailResultVM: detailResultVM, naverApiVM: naverApiVM, locationManager: locationManager, modalLat: $modalLat, modalLon: $modalLon, keyword: $modalPlace)
                    //                    .navigationBarHidden(false)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("일정요약")
                                    .font(.poppins(.NanumSquareOTF_acEB, size: 20)) 
                            }
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    isShowingPhotoSpotMapVIew = false
                                } label: {
                                    Image("arrowLeft")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                    
                                }
                            }
                            
                        }
                }
                //                    .presentationDetents([.large])
            }
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .padding(.top, 3)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("일정요약")
                        .font(.poppins(.NanumSquareOTF_acEB, size: 20)) //.fontWeight(.bold).font(.system(size: 20))
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("현재 위치 설정"),
                    message: Text("현재 위치를 찾기 위해서 권한이 필요해요.\n설정에서 위치 권한을 허용해 주세요"),
                    primaryButton: .destructive(
                        Text("설정"),
                        action: {
                            if let locationSettingsURL = URL(string: UIApplication.openSettingsURLString + "LOCATION_SERVICES") {
                                UIApplication.shared.open(locationSettingsURL)
                            }
                            showAlert = false
                        }
                    ),
                    secondaryButton: .cancel(
                        Text("취소"),
                        action: {
                            showAlert = false
                        }
                    )
                )
            }
            
        }//
        
    }
    
}
