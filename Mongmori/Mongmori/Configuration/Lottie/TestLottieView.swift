//
//  TestLottieView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//
import UIKit
import SwiftUI
import Lottie

struct TestLottieView: View {
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                LottieViewManager(filename: "loadingLottie")
                    .frame(width: 50,height: 50)
                Text("여행 지역 분석 중")
                Spacer()
            }
            
            HStack{
                
                LottieViewManager(filename: "loadingLottie")
                    .frame(width: 50,height: 50)
                Text("여행 일정 확인 중")
                Spacer()
            }
            
            HStack{
                LottieViewManager(filename: "loadingLottie")
                    .frame(width: 50,height: 50)
                Text("AI 몽모리 추천 여행지 생성 중")
                Spacer()
            }
        }
    }
}

#Preview {
    TestLottieView()
}

