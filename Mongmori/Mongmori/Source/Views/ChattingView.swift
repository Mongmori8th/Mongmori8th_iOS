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
    
    @Binding var messages: [Message]
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages, id: \.self) { message in
                        HStack(alignment: .top){
                            Image(message.image ?? "")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40 ,height: 40)
                                .padding(.trailing, -5)
                                .offset(y: 15)
                            MessageView(message: message)
                            //응답 받은걸 어떻게 넣어야함
                        }
                        
                    }
                    // 서버 통신
                    if (messages.count % 2 == 0){
                        ResponseChatResultView()
                    }
                }
                .padding(.top, 25)      //이부분 건들이면 시뮬다시
            }
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
            
            VStack(alignment: message.sender == " " ? .trailing : .leading, spacing: 2) {
                Text(message.content)
                    .padding(10)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .font(.system(size: 15))
                    .cornerRadius(10)   
            }
            
        }
        .padding(.horizontal)
    }
}

