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
    
    @State var region: String = ""
    @State var days: String = ""
    
    @State var testStr: String = ""
    
    @State var messages: [Message] = [
        Message(sender: "몽모리", content: "제주 여행 컨설턴트 AI 몽모리가 아이들과 함께 할수 있는 일정을 추천해드릴게요.\n\n양식에 맞춰 메세지를 보내주시면 AI 몽모리가 일정을 알려드려요!\n\n예시: 애월로 3일 동안 가족여행 갈 거에요.", image: "Mongri"),
    ]
    
    var promptViewModel = PromptViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    VStack{
                        if messages.count == 1{
                            VStack{
                                Image("Mongri")     //화면 가운데
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120 ,height: 120)
                                    .padding(.top, 50)
                                    
                                VStack(alignment: .center){
                                    Text("키즈존 여행 정보를 알려주는")
                                        .font(.poppins(.NanumSquareOTF_acB, size: 12))
                                    Text("AI 챗봇 몽모리에요.")
                                        .font(.poppins(.NanumSquareOTF_acB, size: 12))
                                }
                                
                            }
                            .offset(y: 100)
                            
                        }
                        
                        if !(messages.count == 1){
                            ChattingView(messages: $messages, testStr: $testStr)
                                .padding(.top, 90) // 내려가는것
                        }else{
                            ChattingView(messages: $messages, testStr: $testStr)
                                .padding(.top, 60)
                        }
                    }
                    .frame(width: Screen.maxWidth)
                    .background(Color.orange_100)
//                    .offset(y: 200)
                    
                    HStack {
                        TextField("AI 몽모리에게 메세지를 보내주세요!", text: $newMessage)
                            .font(.poppins(.Pretendard_Regular, size: 14))
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1.5)
                            )
                            .onSubmit {
                                print("Submitted text: \(newMessage)")
                            }
                        Image("material-symbols_send2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                subString(str: newMessage)
                                sendMessage()
                                // 로 숫자 빼내기 함수
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
                Text("몽모리 in Jeju")
                    .fontWeight(.bold)
                    .font(.poppins(.NanumSquareOTF_acEB, size: 18))
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
    
    
    func subString(str: String){
    
        if let index = str.firstIndex(of: "로") {
            let resultString = String(str.prefix(upTo: index))
            region = resultString
        }
        
        for i in str{
            if Int(String(i)) != nil{
                days = String(i)
            }
        }

    }
    
}

#Preview {
    ChatBotView()
}
