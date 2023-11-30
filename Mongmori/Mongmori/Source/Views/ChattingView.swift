//
//  ChattingView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct Message: Hashable{
    var id = UUID()
    var sender: String
    var content: String
    var image: String?
}

struct ChattingView: View {
    
    @State var showText: Bool = true
    
    @Binding var messages: [Message]
    @Binding var testStr: String
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack{
                    ForEach(messages, id: \.self) { message in
                        HStack(alignment: .top){
                            Image(message.image ?? "")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40 ,height: 40)
                                .padding(.trailing, -5)
                                .offset(x: 10, y: 10)       //위의 채팅 귤 움직임
                                
                            MessageView(message: message)
                            //응답 받은걸 어떻게 넣어야함
                        }
                    }
//                    .offset(y: -100)     최근에 고침 스크롤뷰가 위로감
                    // 서버 통신
                    if (messages.count % 2 == 0){
                        if showText{
                            ProgressView()
                                .onAppear{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation {
                                            showText = false
                                        }
                                    }
                                }
                        }else{
                            ResponseChatResultView( testStr: $testStr)
                        }
                        
                    }
                }
//                .padding(.top, 25)      //이부분 건들이면 시뮬다시
            }
            .offset(y: 170)
            
        }
    }
    
}

struct MessageView: View {
    var message: Message
    
    var body: some View {
        HStack {
            if message.sender == " " {
                Spacer()
            }
            VStack(alignment: message.sender == " " ? .trailing : .leading) {
                Text(message.content)
                    .padding(9) //
                    .background(Color.white) // 챗봇, 유저 뒷배경
                    .font(.poppins(.Pretendard_Regular, size: 14))
                    .cornerRadius(20)
                    .offset(y: 15)
            }
        }
        .padding(.horizontal)
    }
}

