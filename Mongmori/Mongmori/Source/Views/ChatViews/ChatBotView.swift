//
//  ChatBotView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct ChatBotView: View {
    
    
    @State private var newMessage: String = ""
    @State private var isButtonEnabled = false  // 메세지 버튼 활성화
    
    @State private var questionExists = false
    
    @State var place: String = ""
    @State var duration: String = ""
    
    @State var scrollViewID = UUID()
    
    @State var messages: [Message] = [
        Message(sender: "몽모리", content: "제주 여행 컨설턴트 AI 몽모리가 아이들과 함께할 수 있는 일정을 추천해드릴게요.\n\n양식에 맞춰 메세지를 보내주시면 AI 몽모리가 일정을 알려드려요!\n\n예시: 애월로 3일 동안 가족여행 갈 거예요.", image: "Mongri"),
    ]
    
    var promptViewModel = PromptViewModel()
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                VStack {
                    ScrollViewReader { proxy in
                        Spacer()
                        if messages.count == 1 {
                            VStack {
                                Image("Mongri")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120, height: 120)
                                    .padding(.top, 50)
                                
                                VStack(alignment: .center) {
                                    Text("키즈존 여행 정보를 알려주는")
                                        .font(.poppins(.NanumSquareOTF_acB, size: 12))
                                        .padding(5)
                                    Text("AI 챗봇 몽모리에요.")
                                        .font(.poppins(.NanumSquareOTF_acB, size: 12))
                                }
                            }
                            .offset(y: -80)
                        }
                        Spacer()
                        ChattingView(scrollViewID: $scrollViewID, place: $place, duration: $duration, messages: $messages)
                            .onAppear {
                                // 특정 ID 값을 사용하여 scrollTo 호출
                                proxy.scrollTo(scrollViewID, anchor: .bottom)
                            }
                    }
                }
                .frame(width: Screen.maxWidth)
                .background(Color.orange_100)

                
                HStack {
                    TextField("AI 몽모리에게 메세지를 보내주세요!", text: $newMessage)
                        .font(.poppins(.Pretendard_Regular, size: 14))
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1.5)
                        )
                    
//                    
                    if !newMessage.isEmpty{
                        Button {
                            if isStringValid(str: newMessage){
                                sendMessage()
                            }else{
                                sendErrorMessage()
                            }
                        } label: {
                            Image("material-symbols_send2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                    }
//                    .disabled(!isButtonEnabled)
                    
                    
                }
                .padding(7)
                .padding([.leading,.trailing] ,17)  // leading,trailing = 24
                
                
            }
            .navigationBarItems(leading: HStack {
                Image("Mongri")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text("몽모리 in Jeju")
                    .font(.poppins(.NanumSquareOTF_acEB, size: 18))
                
            })
            .padding(.top, 3)
            //            .keyboardAwarePadding()
            .onTapGesture {
                hideKeyboard()
            }
        }
        
    }
    
    func sendErrorMessage(){
    
       
//        "안녕하세요! AI 몽모리에요. 작성해주신 형식이 올바르지 않아서 일정을 추천해 드리지 못했어요. 다시 한 번 장소와 날짜를 정확히 입력해 주세요.\n예시: '애월로 3일 동안', '제주시로 5일간'처럼 구체적으로 적어주시면 더욱 정확한 여행 일정을 추천해 드릴게요!"
                
        messages.append(Message(sender: "몽모리", content: "작성해주신 형식이 올바르지 않아서 일정을 추천해 드리지 못했어요. 다시 한 번 장소와 날짜를 정확히 입력해 주세요! \n\n예시: '애월로 3일 동안', '제주시로 5일간'처럼 구체적으로 적어주시면 더욱 정확한 여행 일정을 추천해 드릴게요!", image: "Mongri"))
    
    }
    
    func sendMessage() {
        
        if !newMessage.isEmpty {
            messages.append(Message(sender: "", content: newMessage, image: " "))
            
            messages.append(Message(sender: "몽모리", content: "str", image: "Mongri",button: true))
            newMessage = ""
            // 네트워크 통신하기 newMessage 보내기
        }
        questionExists.toggle()
    }
    
    
    func isStringValid(str: String) -> Bool{
        
        // 바꾸기
        let str = "애월로 3일"
        
        // 정규식 패턴
        let placePattern = #"([가-힣]+로)"#
        let durationPattern = #"(\d+일)"#
        
        let isPlaceValid = str.range(of: placePattern, options: .regularExpression) != nil
        let isDurationValid = str.range(of: durationPattern, options: .regularExpression) != nil
        
        if isPlaceValid && isDurationValid{
            var place = str.range(of: placePattern, options: .regularExpression)
            var duration = str.range(of: durationPattern, options: .regularExpression)
            
            self.place = String(String(str[place!]).dropLast())
            self.duration = String(String(str[duration!]).dropLast())
        
            return true
        }else{
            messages.append(Message(sender: "", content: str, image: ""))
            newMessage = ""
            return false
            
        }
        
    }
    
}

#Preview {
    ChatBotView()
}
