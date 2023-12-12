//
//  LoadingView.swift
//  Mongmori
//
//  Created by 지정훈 on 12/4/23.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var place: String
    @Binding var duration: String
    @Binding var showLoading: Bool

    @State var loadingView1: Bool = true
    @State var loadingView2: Bool = false
    @State var loadingView3: Bool = false
    
    @State var loadingCheckView1: Bool = false
    @State var loadingCheckView2: Bool = false
    @State var loadingCheckView3: Bool = false
    
    var body: some View {
        VStack{
            Image("loadingImage")
                .resizable()
                .frame(width: 350, height: 350)
            
            VStack(alignment: .center){
                VStack(alignment: .center){
                    Text("AI 몽모리가 아이들과 함께하는 \(place) \(duration)박\(Int(duration)!+1)일")
                        .font(.poppins(.Pretendard_Regular, size: 14))
                    Text("여행 일정을 세세하게 계획 중이에요!")
                        .font(.poppins(.Pretendard_Regular, size: 14))
                }
                
                VStack(alignment: .center){
                    
                    if loadingView1{
                        HStack{
                            if loadingCheckView1{
                                Image("loadingCheck")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50,height: 50)
                            }else{
                                LottieViewManager(filename: "loadingLottie")
                                    .frame(width: 50,height: 50)
                            }
                            Text("여행 지역 분석 중")
                            Spacer()
                        }.onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    loadingCheckView1 = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        loadingView2 = true
                                        
                                    }
                                }
                            }
                            
                            

                        }
                    }
                    
                    if loadingView2{
                        HStack{
                            if loadingCheckView2{
                                Image("loadingCheck")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50,height: 50)
                            }else{
                                LottieViewManager(filename: "loadingLottie")
                                    .frame(width: 50,height: 50)
                            }
                           
                            
                            Text("여행 일정 확인 중")
                            Spacer()
                        }.onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    loadingCheckView2 = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        loadingView3 = true
                                        
                                    }
                                }
                            }
                           
                        }
                    }
                    
                    if loadingView3{
                        HStack{
                            if loadingCheckView3{
                                Image("loadingCheck")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50,height: 50)
                            }else{
                                LottieViewManager(filename: "loadingLottie")
                                    .frame(width: 50,height: 50)
                            }
                            Text("AI 몽모리 추천 여행지 생성 중")
                            Spacer()
                        }.onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    loadingCheckView3 = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        showLoading = false
                                        
                                    }
                                }
                            }
                            
                        }
                    }
                }
                .offset(x: 70)
                
            }
            .offset(y: -30)
            
            
            
            Spacer()
        }
        
        
    }
}

//#Preview {
//    LoadingView(place: place, duration: duration, showLoading: showLoading)
////}
