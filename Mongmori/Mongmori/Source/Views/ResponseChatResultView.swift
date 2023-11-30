//
//  ResponseChatResultView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI
// MARK: - 응답 채팅 결과 뷰

struct ResponseChatResultView: View {
    
    @State var messages: Message =
    Message(sender: "뭉디", content: "AI 뭉디가 아이들과 함께하는 서귀포 1박 2일 여행 일정을 준비했어요", image: "Mongri")
    
    
    var body: some View {
        
        HStack(alignment: .top){
            Image(messages.image ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40 ,height: 40)
                .padding(.trailing, -5)
                .offset(y: 15)
            ResponseMessageView(message: messages)
            //응답 받은걸 어떻게 넣어야함
        }
        
        
    }
}

struct ResponseMessageView: View {
    var message: Message
    
    var body: some View {
        HStack {
            if message.sender == " " {
                Spacer()
            }
            
            VStack(alignment: message.sender == " " ? .trailing : .leading, spacing: 2) {
                
                
                HStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .frame(width: Screen.maxWidth * 0.73, height: Screen.maxHeight * 0.15)
                        .overlay {
                            HStack{
                                VStack() {
                                    Text(message.content)
                                        .font(.system(size: 15))
                                        .padding([.bottom] , 15)
                                    
                                    Button(action: {
                                        //액션
                                    }) {
                                        NavigationLink(destination: ResultsSummaryScreen(locationManager: LocationManager())) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(.orange)
                                                .frame(width: Screen.maxWidth * 0.67, height: 30)
                                                .overlay{
                                                    Text("일정 보러가기 >")
                                                        .bold()
                                                        .foregroundColor(.white)
                                                }
                                        }
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                }
                .background(Color.clear)
            }
            .padding(.horizontal)
        }
    }
}
#Preview {
    ResponseChatResultView()
}
