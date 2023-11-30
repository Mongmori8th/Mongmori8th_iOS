//
//  ChatBotView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct ChatBotView: View {

    @State private var userInput: String = ""
    @State private var outputText: String = ""
    @State private var newMessage: String = ""
    
    @State var messages: [Message] = [
        Message(sender: "뭉디", content: "제주 여행 컨설턴트 AI 뭉디가 아이들과 함께할수 있는 일정을 추천해드릴게요.\n\n양식에 맞춰 메세지를 보내주시면 AI뭉디가 일정을 알려드려요!\n\n예시: 애월로 3일 동안 가족여행 갈 거에요", image: "Mongri"),
    ]
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    VStack{
                        if messages.count == 1{
                            Image("Mongri")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120 ,height: 120)
                                .padding(.top, 60)
                        }
                        
                        if !(messages.count == 1){
                            ChattingView(messages: $messages)
                                .padding(.top, -20)
                        }else{
                            ChattingView(messages: $messages)
                                .padding(.top, 60)
                        }
                    }
                    .frame(width: Screen.maxWidth)
                    .background(Color.orange_100)
                    
                    HStack {
                        TextField("AI 뭉디에게 메세지를 보내주세요!", text: $newMessage)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray, lineWidth: 1.5)
                            )
                        Image("material-symbols_send2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                sendMessage()
                            }
                    }
                    .padding(7)
                    .padding([.leading,.trailing] ,3)
                    
                }

            }
            .navigationBarItems(leading: HStack {
                Image("Mongri")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text("뭉디 in Jeju")
                    .font(.subheadline)
                    .bold()
            })
            .padding(.top, 3)
        }
        
    }
    
    func sendMessage() {
        
        if !newMessage.isEmpty {
            messages.append(Message(sender: " ", content: newMessage, image: " "))
            newMessage = ""
            // 네트워크 통신하기 newMessage 보내기
        }
    }
}

#Preview {
    ChatBotView()
}


