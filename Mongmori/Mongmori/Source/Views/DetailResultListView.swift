//
//  DetailResultListView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

// MARK: - 리스트 상세 결과값

struct DetailResultListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var clickedButtonLoad: Bool = true
    @State var clickedButtonCall: Bool = true
    
    
    var body: some View {
        VStack{
            VStack(alignment: .center){
                Image("test1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Screen.maxWidth ,height: 250)
                
                VStack(alignment: .leading){
                    Text("제주동문화공원")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .padding(.bottom, 7)
                    
                    HStack{
                        Image("IntelliSenseEventIcon_final1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20,height: 20)
                            .offset(y: -3)
                        Text("제주시 조천읍 남조로 2023")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .padding(.bottom, 4)
                        Spacer()
                    }
                    
                    HStack{
                        Image("IntelliSenseEventIcon_final1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20,height: 20)
                            .offset(y: -8)
                        
                        Text("나와의 거리 102km")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                    
                }
                .padding([.leading] ,25)
                
                HStack{
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(clickedButtonLoad ? Color.white : Color.orange)
                            .frame(width: Screen.maxWidth * 0.38, height: 35)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(clickedButtonLoad ? Color.orange : Color.white, lineWidth: 2)
                                HStack {
                                    Image(clickedButtonLoad ? "heroicons_map-pin1" : "heroicons_map-pin_white1" )
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                    Text("길찾기")
                                        .bold()
                                        .foregroundColor(clickedButtonLoad ? Color.orange : Color.white)
                                }
                                .onTapGesture {
                                    clickedButtonLoad.toggle()
                                }
                            }
                    }
                    
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(clickedButtonCall ? Color.white : Color.orange)
                            .frame(width: Screen.maxWidth * 0.38, height: 35)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(clickedButtonCall ? Color.orange : Color.white, lineWidth: 2)
                                HStack {
//                                    Image(clickedButtonCall ?
//                                          "fluent_call-20-regular" : "Frame_1516")
                                    Image(clickedButtonCall ?
                                          "Frame_1516" : "Vector")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                    Text("전화하기")
                                        .bold()
                                        .foregroundColor(clickedButtonCall ? Color.orange : Color.white)
                                }
                                .onTapGesture {
                                    clickedButtonCall.toggle()
                                }
                            }
                    }
                    
                    
                }
                .padding(.bottom, 20)
                .navigationBarBackButtonHidden(true)
                .padding(.top, 20)
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.lightGray)
                    .frame(width: Screen.maxWidth * 0.8, height: 130)
                    .shadow(color: Color.black.opacity(0.2), radius: 3, y: 2)
                    .overlay{
                        VStack(alignment: .leading){
                            Text("세부 일정")
                                .fontWeight(.bold)
                                .font(.title2)
                                .padding(.bottom, 12)
                            
                            Text("오후: 애월갯벌 체험과 애월향 산책 \n애월갯벌에서 갯벌 체험후 애월항 산책로에서 휴식")
                        }
                        .offset(x: -15)
                        
                    }
                    
                Spacer()
            }
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("일정요약")
                        .font(.title2.bold())
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("BackPageIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        
                    }
                }
                
            }
        }
    }
}
#Preview {
    DetailResultListView()
}
