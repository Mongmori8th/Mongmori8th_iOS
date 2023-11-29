//
//  ChatBotView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct ChatBotView: View {
    @State var touchMessageClicked: Bool = true
    
    @State private var userInput: String = ""
    @State private var outputText: String = ""
    
    var body: some View {
        VStack{
            Rectangle()
                .fill(Color.scrollViewBackGround)
                .frame(width: Screen.maxWidth , height: 80)
                .padding(.bottom, 10)
                .overlay{
                    Text("뭉디 in Jeju")
                        .font(.title)
                        .fontWeight(.bold)
                }
            
            Spacer()
            
            if touchMessageClicked{
                Image("test2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120 ,height: 120)
            }
            Spacer()
            
            
            VStack {
                TextField("입력하세요", text: $userInput)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("확인") {
                    outputText = "입력된 내용: \(userInput)"
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)

                Text(outputText)
                    .padding()
            }
            .padding()
            
        }
    }
}

#Preview {
    ChatBotView()
}
