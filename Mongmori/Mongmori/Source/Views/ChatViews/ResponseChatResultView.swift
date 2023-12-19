//
//  ResponseChatResultView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI
// MARK: - 응답 채팅 결과 뷰

struct ResponseChatResultView: View {
    
    @ObservedObject var chatVM : ChatViewModel
    @ObservedObject var locationManager : LocationManager
    @ObservedObject var detailResultVM : DetailResultViewModel
    
    let jejuSpot : [JejuSpot]
    
    @Binding var place: String
    @Binding var duration: String
    @Binding var messages: [Message]
    @Binding var currentDate: Date
    
    @State private var showText = false
    
    var body: some View {
        HStack(alignment: .top){
            
            Image("Mongri")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40 ,height: 40)
                .offset(y: 10)
        
            
            VStack(alignment: .center) {
                Text("AI 몽모리가 아이들과 함께하는 \(place) \(Int(duration)!-1)박\(duration)일 여행 일정을 준비했어요!")
                    .font(.poppins(.Pretendard_Regular, size: 14))
//                    .kerning(18)
                    .lineSpacing(6)
                    .padding([.top,.leading,.trailing],12)
                
                NavigationLink {
                    ResultsSummaryScreen(place: $place, duration: $duration, currentDate: $currentDate, chatVM: chatVM, detailResultVM: detailResultVM, locationManager: locationManager, responseData: chatVM.tourResponse!, jejuSpot: jejuSpot)
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color.orange_500)
                        .frame(width: Screen.maxWidth * 0.72, height: 30)
                        .overlay{
                            HStack{
                                Text("일정 보러가기")
                                    .font(.poppins(. NanumSquareOTF_acEB, size: 14))
//                                    .kerning(18)
                                    .lineSpacing(6)
                                    .foregroundColor(.white)
                                Image("ChevronRightIcon_white_F")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                            }
                            .padding([.top,.bottom],8)
                            .padding([.leading,.trailing],20)
                           
                        }
                }
                .padding([.bottom,.leading,.trailing],12)
                .padding(.top,10)

            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.grey_200, lineWidth: 1.5)
            )
            .background(Color.white) // 챗봇, 유저 뒷배경
            .cornerRadius(12)
            
        }
        .padding(
            EdgeInsets(
                top: 0,
                leading: 14,
                bottom: 12,
                trailing: 24
            )
        )
    }
}
