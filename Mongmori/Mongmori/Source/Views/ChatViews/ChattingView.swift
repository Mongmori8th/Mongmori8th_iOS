//
//  ChattingView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct Message: Hashable{
    var id = UUID()
    var sender: String?
    var content: String
    var image: String?
}

struct ChattingView: View {
    
    @State var showProgress: Bool = true
    
    @Binding var place: String
    @Binding var duration: String
    @Binding var messages: [Message]
    
    var body: some View {
        
        ScrollView {
            VStack{
                ForEach(messages, id: \.self) { message in
                    MessageView(message: message)
                }
                
                if (messages.count % 2 == 0){
                    
                    if showProgress{
                        ProgressView()
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation {
                                        showProgress = false
                                    }
                                }
                            }
                            .offset(y: 20)
                    }else{
                        ResponseChatResultView(place: $place, duration: $duration, messages: $messages)
                    }
                    
                }
            }
        }
        .frame(height: messages.count == 1 ? 150 : 350) // 바꾸끼
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
                    .padding(12)
                    .background(Color.white) // 챗봇, 유저 뒷배경
                    .cornerRadius(12)
            }
        }
        .padding(
            EdgeInsets(
                top: 0,
                leading: message.sender == "" ? 0 : 14,
                bottom: 12,
                trailing: message.sender == "" ? 24 : 24
            )
        )
    }
}

#Preview {
    MessageView(message: Message(sender: "몽모리", content: "제주 여행 컨설턴트 AI 몽모리가 아이들과 함께할 수 있는 일정을 추천해드릴게요.\n\n양식에 맞춰 메세지를 보내주시면 AI 몽모리가 일정을 알려드려요!\n\n예시: 애월로 3일 동안 가족여행 갈 거예요.", image: "Mongri"))
}
