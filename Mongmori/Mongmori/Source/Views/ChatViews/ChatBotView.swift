//
//  ChatBotView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct ChatBotView: View {
    
    @StateObject var chatVM = ChatViewModel()
    @StateObject var detailResultVM = DetailResultViewModel()
    @StateObject var locationManager = LocationManager()
    
    @State private var newMessage: String = ""
    
    @State var place: String = ""
    @State var duration: String = ""

    @State var scrollViewID = UUID()
    
    @FocusState private var textfieldFocused: Bool
    
    @State var messages: [Message] = [
        Message(sender: "몽모리", content: "제주 여행 컨설턴트 AI 몽모리가 아이들과 함께할 수 있는 일정을 추천해드릴게요.\n\n양식에 맞춰 메세지를 보내주시면 AI 몽모리가 일정을 알려드려요!\n\n예시: 애월로 3일 동안 가족여행 갈 거예요.", image: "Mongri"),
    ]
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        NavigationStack{
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
                        ChattingView(chatVM: chatVM, locationManager: locationManager, jejuSpot: detailResultVM.jejuTourList, scrollViewID: $scrollViewID, place: $place, duration: $duration, messages: $messages)
                            .onAppear {
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
                                .stroke(Color.grey_200, lineWidth: 1.5)
                        )
                        .focused($textfieldFocused)
                        .onLongPressGesture(minimumDuration: 0.0) {
                            textfieldFocused = true
                        }
                        .autocorrectionDisabled()
                    
//                    
                    if !newMessage.isEmpty{
                        Button {
                            if isStringValid(str: newMessage){
                                let result = chatVM.sendMessage(messages: messages, newMessage: newMessage, place: self.place, duration: self.duration)
                                messages = result.0
                                newMessage = result.1
                            }else{
                                messages = chatVM.sendErrorMessage(messages: messages)
                            }
                        } label: {
                            Image("send")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                    }
                    
                }
                .padding(7)
                .padding([.leading,.trailing] ,17)
                
                
            }
            .onAppear{
                detailResultVM.fetchJsonData()
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
    
    func isStringValid(str: String) -> Bool{
        
        // 바꾸기
//        let str = "애월로 1일"
        
        let placePattern = #"([가-힣]+로)"#
        let durationPattern = #"(\d+일)"#
        
        let isPlaceValid = str.range(of: placePattern, options: .regularExpression) != nil
        let isDurationValid = str.range(of: durationPattern, options: .regularExpression) != nil
        
        if isPlaceValid && isDurationValid{
            let place = str.range(of: placePattern, options: .regularExpression)
            let duration = str.range(of: durationPattern, options: .regularExpression)
            
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
