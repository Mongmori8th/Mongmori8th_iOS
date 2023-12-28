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
    @State var currentDate: Date = Date()
    @State var scrollViewID = UUID()
    @State private var viewOffset: CGFloat = 0
    @State var shouldShowView: Bool = false
    
    @FocusState private var textfieldFocused: Bool
    
    @State var messages: [Message] = [
        Message(sender: "몽모리", content: "제주 여행 컨설턴트 AI 몽모리가 아이들과 함께할 수 있는 일정을 추천해드릴게요.\n\n양식에 맞춰 메세지를 보내주시면 AI 몽모리가 일정을 알려드려요!\n\n장소: 서귀포로\n일정: 12월 18일부터 12월 20일까지", image: "Mongri"),
    ]
    
    var body: some View {
            NavigationStack{
                if locationManager.statusString == "notDetermined" {
                    Text("")
                }else{
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
                                ChattingView(chatVM: chatVM, locationManager: locationManager, detailResultVM: detailResultVM, jejuSpot: detailResultVM.jejuTourList, scrollViewID: $scrollViewID, place: $place, duration: $duration, messages: $messages, currentDate: $currentDate)
                                    .onAppear {
                                        proxy.scrollTo(scrollViewID, anchor: .bottom)
                                    }
                            }
                        }
                        .frame(width: Screen.maxWidth)
                        .background(Color.orange_100)
                        .padding(.top, 5)
                        
                        HStack {
                            TextField("AI 몽모리에게 메세지를 보내주세요!", text: $newMessage)
                                .font(.poppins(.Pretendard_Regular, size: 14))
                            //                            .kerning(18)
                                .lineSpacing(6)
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
                        .padding(.top, 7)
                        .padding([.leading,.trailing] ,17)
                    }
                    .offset(y: -viewOffset) // 뷰의 오프셋을 설정하여 키보드와 함께 이동
                    .onAppear{
                        subscribeToKeyboardEvents()
                        detailResultVM.fetchJsonData()
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .navigationBarItems(leading: HStack {
                        Image("Mongri")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text("몽모리 in Jeju")
                            .font(.poppins(.NanumSquareOTF_acEB, size: 18))
                            .lineSpacing(7)
                        
                        Spacer()
                        
                    } .padding(.top, 3))
                   
                }
            }

        
    }
    
    // MARK: - 세부 기능 설정 코드
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    private func subscribeToKeyboardEvents() {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    let keyboardHeight = keyboardFrame.height
                    let textFieldBottom = UIScreen.main.bounds.height - self.textFieldBottomPosition
                    let offset = max(0, keyboardHeight - textFieldBottom)
                    self.viewOffset = offset
                }
            }

            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.viewOffset = 0
            }
        }

    private var textFieldBottomPosition: CGFloat {
        print(UIScreen.main.bounds.height)
        switch UIScreen.main.bounds.height{
        case 852.0...1000.0:
            return UIScreen.main.bounds.height - 290
        case 812.0..<852.0:
            return UIScreen.main.bounds.height - 250
        default:
            return UIScreen.main.bounds.height - 160
        }
        
    }
    
    private func isStringValid(str: String) -> Bool{
    
        
//        let str = "애월로 12월 31일부터 1월 1일까지 아이와 함께 여행할 거예요!"
        
        let placePattern = #"([가-힣]+로)"#
        //        let durationPattern = #"(\d+일)"#
        
        let durationPattern = #"(\d{1,2})월 (\d{1,2})일부터 (\d{1,2})월 (\d{1,2})일"#
        let regex = try! NSRegularExpression(pattern: durationPattern, options: [])
        let matches = regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.utf16.count))
        
        
        let isPlaceValid = str.range(of: placePattern, options: .regularExpression) != nil
        //        let isDurationValid = str.range(of: durationPattern, options: .regularExpression) != nil
        
        
        if isPlaceValid{
            let place = str.range(of: placePattern, options: .regularExpression)
            //            let duration = str.range(of: durationPattern, options: .regularExpression)
            //            self.duration = String(String(str[duration!]).dropLast())
            self.place = String(String(str[place!]).dropLast())
            
            
            if let match = matches.first {
                let month1 = (str as NSString).substring(with: match.range(at: 1))
                let day1 = (str as NSString).substring(with: match.range(at: 2))
                
                let month2 = (str as NSString).substring(with: match.range(at: 3))
                let day2 = (str as NSString).substring(with: match.range(at: 4))
                
                let calendar = Calendar.current
                let currentDate = Date()
                let currentYear = calendar.component(.year, from: currentDate)
                let currentMonth = calendar.component(.month, from: currentDate)
                
                var dateComponents1 = DateComponents()
                dateComponents1.year = currentYear
                dateComponents1.month = Int(month1)
                dateComponents1.day = Int(day1)
                let date1 = calendar.date(from: dateComponents1)!
                
                if month1 > month2 {
                    var dateComponents2 = DateComponents()
                    dateComponents2.year = currentYear + 1
                    dateComponents2.month = Int(month2)
                    dateComponents2.day = Int(day2)
                    let date2 = calendar.date(from: dateComponents2)!
                    
                    let dateDifference = calendar.dateComponents([.day], from: date1, to: date2)
                    self.duration = String((dateDifference.day ?? 0) + 1)
                    
                }else{
                    var dateComponents2 = DateComponents()
                    dateComponents2.year = currentYear
                    dateComponents2.month = Int(month2)
                    dateComponents2.day = Int(day2)
                    let date2 = calendar.date(from: dateComponents2)!
                    
                    let dateDifference = calendar.dateComponents([.day], from: date1, to: date2)
                    self.duration = String((dateDifference.day ?? 0) + 1)
                }
                
                self.currentDate = date1
                
                return true
            } else {
                messages.append(Message(sender: "", content: str, image: ""))
                newMessage = ""
                return false
                
            }
        }else{
            messages.append(Message(sender: "", content: str, image: ""))
            newMessage = ""
            return false
            
        }
        
    }
}

//#Preview {
//    ChatBotView()
//}
