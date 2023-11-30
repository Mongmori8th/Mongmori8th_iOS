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
    Message(sender: "몽모리", content: "AI 몽모리가 아이들과 함께하는 서귀포 1박 2일 여행 일정을 준비했어요.", image: "Mongri")
    
    @Binding var testStr: String
    
    var body: some View {
        
        HStack(alignment: .top){
            Image(messages.image ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40 ,height: 40)
                .padding(.trailing, -5)
                .offset(x: 10, y: -95)     //아래쪽 캐릭터
            ResponseMessageView(message: messages, testStr: $testStr)
            //응답 받은걸 어떻게 넣어야함
        }
        .offset(y: 120)
        
        
    }
}

struct ResponseMessageView: View {
    var message: Message
    
    @Binding var testStr: String
    
    @State private var showText = false
    
    
    var body: some View {
        
        HStack {
            if message.sender == " " {
                Spacer()
            }
            
            VStack(alignment: message.sender == " " ? .trailing : .leading, spacing: 2) {
                
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .frame(width: Screen.maxWidth * 0.80, height: Screen.maxHeight * 0.15)
                        .overlay {
                            HStack{
                                VStack() {
                                    Text(message.content)
                                        .font(.system(size: 15))
                                        .padding([.bottom] , 15)
                                        .padding([.leading, .trailing], 10)
                                    
                                    Button(action: {
                                        
                                    }) {
                                        NavigationLink(destination: ResultsSummaryScreen(locationManager: LocationManager(), testStr: $testStr)) {
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundColor(Color.orange_500)
                                                .frame(width: Screen.maxWidth * 0.72, height: 30)
                                                .overlay{
                                                    HStack{
                                                        Text("일정 보러가기")
                                                            .font(.poppins(. NanumSquareOTF_acEB, size: 14))
                                                            .font(.system(size: 16))
                                                            .fontWeight(.heavy)
                                                            .foregroundColor(.white)
                                                        Image("ChevronRightIcon_white_F")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 20, height: 20)
                                                    }
                                                   
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
            .offset(y: -100)
        }
        
        
    }
}
//#Preview {
//    ResponseChatResultView()
//}

