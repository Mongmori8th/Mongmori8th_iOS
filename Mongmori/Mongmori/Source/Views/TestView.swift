//
//  TestView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//
import SwiftUI

struct Message: Identifiable {
    var id = UUID()
    var sender: String
    var content: String
}

struct TestView: View {
    
    @State private var messages: [Message] = [
        Message(sender: "뭉디", content: "뭉디입니다. 아이들과 함께 할 수 있는 일정을 추천해드릴게요.\n\n양식에 맞춰 메세지를 보내주시면 AI뭉디가 일정을 알려드려요!\n\n장소:\n\n일정:\n\n양식에 맞춰 작성해주세요."),
    ]

    @State private var newMessage: String = ""

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(messages) { message in
                        MessageView(message: message)
                    }
                }
                .padding()
            }
            
            HStack {
                TextField("챗봇에게 메시지 보내기", text: $newMessage)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 1.5)
                    )
                    .padding()

                Button("▶︎") {
                    sendMessage()
                }
                .padding(10)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
        }
    }

    func sendMessage() {
        if !newMessage.isEmpty {
            messages.append(Message(sender: "나", content: newMessage))
            newMessage = ""
        }
    }
}

struct MessageView: View {
    var message: Message

    var body: some View {
        HStack {
            if message.sender == "나" {
                Spacer()
            }

            VStack(alignment: message.sender == "나" ? .trailing : .leading, spacing: 2) {
                Text(message.sender)
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(message.content)
                    .padding(8)
                    .background(message.sender == "나" ? Color.blue : Color.gray.opacity(0.8))
                    .foregroundColor(message.sender == "나" ? .white : .black)
                    .cornerRadius(10)
            }
            .background(message.sender == "나" ? Color.clear : Color.white)
        }
        .padding(.horizontal)
    }
}


