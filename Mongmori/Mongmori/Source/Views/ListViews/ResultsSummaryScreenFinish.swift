////
////  ResultsSummaryScreen.swift
////  Mongmori
////
////  Created by 지정훈 on 11/30/23.
////
//
//
//// MARK: - AI Results Summary Screen ( AI 챗봇 결과에서 넘어오는 요약 뷰 )
//
//import SwiftUI
//
//struct ResultsSummaryScreenFinish: View {
//    
//    let jejuSpot : [JejuSpot]
//    
//    @Binding var place: String
//    @Binding var duration: String
//    
//    @ObservedObject var chatVM : ChatViewModel
//    
//
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @ObservedObject var locationManager : LocationManager
//    
//    @State private var showLoading = true
//    
//    
//    var userLatitude: Double {
//        return locationManager.lastLocation?.coordinate.latitude ?? 0.0
//    }
//    var userLongitude: Double {
//        return locationManager.lastLocation?.coordinate.longitude ?? 0.0
//    }
//    
//    var body: some View {
//        
//        if false{ //고치기
//            //        if showLoading{ //고치기
//            LoadingView(place: $place, duration: $duration, showLoading: $showLoading)
//                .navigationBarBackButtonHidden(true)
//        }else{
//            VStack {
//                MapView(locationManager: LocationManager(), userLatitude: userLatitude, userLongitude: userLongitude)
//                
//                ScrollView{
//                    
//                    ForEach(Array(chatVM.parseTourResponse().enumerated()), id: \.element.day) { (index, dayPlan) in
//                        VStack(alignment: .leading){
//                            
//                            Text("Day \(index+1) : 애월해안도로와 애월 바다마을")
//                                .font(.system(size: 20))
//                                .fontWeight(.bold)
//                                .offset(x: 5, y: -10)
//                            
////                            ForEach(Array(dayPlan.activities.enumerated()), id: \.element) { (index, activity) in
////                                    ResultListView(jejuSpot: jejuSpot, index: index, str: activity)
////                                        .padding(.bottom , 15)
////                                
////                            }
//                            
//                        }.padding()
//                    }
//                    
//                    
                    
//                    RoundedRectangle(cornerRadius: 12)
//                        .foregroundColor(.lightGray2)
//                        .frame(width: Screen.maxWidth * 0.8, height: Screen.maxHeight * 0.15)
//                        .overlay {
//                            VStack(){
//                                HStack{
//                                    Image("bulb")
//                                        .resizable()
//                                        .frame(width: 30, height: 30)
//                                    Spacer()
//                                }
//                                .padding(.bottom, 12)
//                                
//                                Text("이렇게 거리 순서와 함께 넘버링된 일정을 참고 하여 즐거운 여행되시길 바랍니다!")
//                                    .font(.poppins(.Pretendard_Bold, size: 16))
//                            }
//                            .padding(
//                                EdgeInsets(
//                                    top: 10,
//                                    leading: 16,
//                                    bottom: 10,
//                                    trailing: 16
//                                )
//                            )
//                        }
//                        .padding(
//                            EdgeInsets(
//                                top: 10,
//                                leading: 24,
//                                bottom: 0,
//                                trailing: 24
//                            )
//                        )
                    
//                    
//                    
//                    
//                    
//                }
//                // 전구뷰??
//                
//            }
//            .background(Color.white)
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden(true)
//            .padding(.top, 3)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("일정요약")
//                    //                        .fontWeight(.bold)
//                    //                        .font(.system(size: 20))
//                        .font(.poppins(.NanumSquareOTF_acEB, size: 20))
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        self.presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Image("BackPageIcon")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 20, height: 20)
//                        
//                    }
//                }
//                
//            }
//            
//        }
//        
//    }
//    
//}
//
////#Preview {
////    ResultsSummaryScreen(place: "애월", duration: "3", presentationMode: Binding<PresentationMode>, locationManager: LocationManager(), showLoading: false)
////}
