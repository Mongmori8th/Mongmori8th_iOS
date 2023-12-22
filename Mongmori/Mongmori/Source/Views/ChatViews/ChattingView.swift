//
//  ChattingView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct ChattingView: View {
    
    @ObservedObject var chatVM : ChatViewModel
    @ObservedObject var locationManager : LocationManager
    @ObservedObject var detailResultVM : DetailResultViewModel
    
    let jejuSpot : [JejuSpot]
    
    @State var showProgress: Bool = true
    @Binding var scrollViewID: UUID
    @Binding var place: String
    @Binding var duration: String
    @Binding var messages: [Message]
    @Binding var currentDate: Date
    
    var body: some View {
        
        ScrollView {
            VStack{
                ForEach(messages, id: \.self) { message in
                    
                    if message.button == true{
                        if chatVM.tourResponse != nil{
                            ResponseChatResultView(chatVM: chatVM, locationManager: locationManager, detailResultVM: detailResultVM, jejuSpot: jejuSpot, place: $place, duration: $duration, messages: $messages, currentDate: $currentDate)
                        }else{
                            ProgressView()
                        }
                    }else{
                        MessageView(message: message)
                        
                    }
                    
                }
                .onAppear{
                    scrollViewID = messages.last?.id ?? UUID()
                }
                
                
            }
            
        }
        .frame(height: messages.count == 1 ? 210 : chatVM.minHeight(count: messages.count, messages: messages)) // 바꾸끼
        .padding(.bottom, 12)
        
        
        
    }
    
}

struct MessageView: View {
    var message: Message
    
    var body: some View {
        
        HStack(alignment: .top){
            if message.sender == "" {
                Spacer()
            }else{
                Image(message.image ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40 ,height: 40)
                    .offset(y: 10)
            }
            
            VStack(alignment: message.sender == "" ? .trailing : .leading) {
                
                Text(message.content)
                    .font(.poppins(.Pretendard_Regular, size: 14))
                    .lineSpacing(2)
//                    .kerning(18)
                    .lineSpacing(6)
                    .padding(12)
                    .background(Color.white) // 챗봇, 유저 뒷배경
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.grey_200, lineWidth: 1.5) // 테두리 색 및 두께 조절
                    )
            }
        }
        .padding(
            EdgeInsets(
                top: 1,
                leading: message.sender == "" ? 0 : 14,
                bottom: 12,
                trailing: message.sender == "" ? 24 : 24
            )
        )
    }
}

//#Preview {
//    MessageView(message: Message(sender: "몽모리", content: "제주 여행 컨설턴트 AI 몽모리가 아이들과 함께할 수 있는 일정을 추천해드릴게요.\n\n양식에 맞춰 메세지를 보내주시면 AI 몽모리가 일정을 알려드려요!\n\n예시: 애월로 3일 동안 가족여행 갈 거예요.", image: "Mongri"))
//}
