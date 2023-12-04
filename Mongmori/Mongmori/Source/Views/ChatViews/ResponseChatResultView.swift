//
//  ResponseChatResultView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI
// MARK: - 응답 채팅 결과 뷰

struct ResponseChatResultView: View {
    
    @Binding var place: String
    @Binding var duration: String
    @Binding var messages: [Message]
    
    @State private var showText = false
 
    var body: some View {
        HStack(alignment: .top){
            
            Image("Mongri")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40 ,height: 40)
                .offset(y: 10)
        
            
            VStack(alignment: .center) {
                Text("AI 몽모리가 아이들과 함께하는 \(place) \(duration)박\(Int(duration)!+1)일 여행 일정을 준비했어요!")
                    .font(.poppins(.Pretendard_Regular, size: 14))
                    .padding([.top,.leading,.trailing],12)
                
                Button(action: {
                    
                }) {
                    NavigationLink(destination: ResultsSummaryScreen(place: $place, duration: $duration, locationManager: LocationManager())){
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color.orange_500)
                            .frame(width: Screen.maxWidth * 0.72, height: 30)
                            .overlay{
                                HStack{
                                    Text("일정 보러가기")
                                        .font(.poppins(. NanumSquareOTF_acEB, size: 14))
//                                                            .font(.system(size: 16))
//                                                            .fontWeight(.heavy)
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
                }
                .padding([.bottom,.leading,.trailing],12)
                .padding(.top,10)
                
        
            }
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
