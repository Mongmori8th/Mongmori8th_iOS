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
    @State private var isButtonEnabled = false  // 메세지 버튼 활성화
    @State private var isShowingAlert = false  // 형식에 맞지 않는 알럿
    
    @State var place: String = ""
    @State var duration: String = ""
    
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
                    ChattingView(place: $place, duration: $duration, messages: $messages)
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
                        .onChange(of: newMessage) { newValue in
                            isButtonEnabled = !newValue.isEmpty
                        }
                    
                    if isButtonEnabled{
                        Button {
                            // 형식 확이
                            if isStringValid(str: newMessage){
                                sendMessage()
                            }else{
                                isShowingAlert = true
                            }
                            
                        } label: {
                            Image("material-symbols_send2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                        .disabled(!isButtonEnabled)
                        
                        .alert(isPresented: $isShowingAlert) {
                            Alert(
                                title: Text("입력 형식이 올바르지 않습니다!"),
                                message: Text("장소와 날짜를 다음과 같이 입력해주세요.\n\n예시: 애월로 3일동안\n\t 제주시로 5일간\n\t      서귀포시로 2일동안"),
                                dismissButton: .default(Text("다시쓰기")){
                                    isShowingAlert = false
                                })
                        }
                        
                    }
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
    
    func sendMessage() {
        
        if !newMessage.isEmpty {
            messages.append(Message(sender: "", content: newMessage, image: " "))
            newMessage = ""
            // 네트워크 통신하기 newMessage 보내기
        }
    }
    
    
    func isStringValid(str: String) -> Bool{
        
        // 바꾸기
        //        let str = "애월로 3일"
        
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
            return false
            
        }
        
    }
    
}

#Preview {
    ChatBotView()
}

