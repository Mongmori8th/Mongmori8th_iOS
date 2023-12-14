//
//  MongmoriApp.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

import SwiftUI


@main
struct MongmoriApp: App {
    @State var showView : Bool = true
    

    var body: some Scene {
        WindowGroup {
//            if showView{
//                OnboardingView()
//                    .onAppear{
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            withAnimation {
//                                showView = false
//                            }
//                        }
//                    }
//            }else{
                ChatBotView()
                
//            }
            
//            ChatBotView()
//            NaverNaviView()
            
        }
        
    }
}

