//
//  MongmoriApp.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

import SwiftUI

@main
struct MongmoriApp: App {
    
//    @State var messages: [Message] = [
//        Message(sender: "뭉디", content: "제주 여행 컨설턴트 AI 뭉디가 아이들과 함께할수 있는 일정을 추천해드릴게요.\n\n양식에 맞춰 메세지를 보내주시면 AI뭉디가 일정을 알려드려요!\n\n예시: 애월로 3일 동안 가족여행 갈 거에요", image: "Mongri"),
//    ]
    
    var body: some Scene {
        WindowGroup {
            ChatBotView()
//            ChattingView(messages: $messages)
//            ResultsSummaryScreen(locationManager: LocationManager())
//            DetailResultListView()
            
//            ResponseChatResultView()
//            TestView()
        }
    }
}
