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
            
            
            if touchMessageClicked{
                Image("test2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120 ,height: 120)
                    .padding(.top, 60)
            }
            
            
            if !touchMessageClicked{
                ChattingView(touchBool: $touchMessageClicked)
                    .padding(.top, -20)
            }else{
                ChattingView(touchBool: $touchMessageClicked)
                    .padding(.top, 40)
            }


        }
    }
}

#Preview {
    ChatBotView()
}
