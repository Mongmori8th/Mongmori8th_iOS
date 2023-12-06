//
//  DetailResultListView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI
import KakaoSDKNavi
// MARK: - 리스트 상세 결과값

struct DetailResultListView: View {
    
    @StateObject var detailResultViewModel = DetailResultViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var clickedButtonLoad: Bool = true
    @State var clickedButtonCall: Bool = true
 
    var index: Int
    
    var body: some View {
        VStack{
            Image("detailImage1")
                .resizable()
            //                    .aspectRatio(contentMode: .fit)
                .frame(width: Screen.maxWidth ,height: 250)
            
            // MARK: - 여행지 이름
            VStack(alignment: .leading){
                HStack{
                    Text("협재해수욕장")
                        .font(.poppins(.NanumSquareOTF_acEB, size: 20)) //.font(.system(size: 20))  .fontWeight(.bold)
                    Spacer()
                }
                
            }
            .padding(
                EdgeInsets(
                    top: 24,
                    leading: 24,
                    bottom: 8,
                    trailing: 10
                )
            )
            
            // MARK: - 여행지 주소 및 거리 표시
            VStack{
                HStack{
                    Image("IntelliSenseEventIcon_final1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                    Text("제주특별자치도 제주시 한림읍 한림로 329-10")
                        .font(.poppins(.Pretendard_Regular, size: 16))  //.font(.system(size: 16))
                    Spacer()
                }

                
                HStack{
                    Image("IntelliSenseEventIcon_final1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)

                    
                    Text("나와의 거리 16km")
                        .font(.poppins(.Pretendard_Regular, size: 16))  //.font(.system(size: 16))
                    Spacer()
                }
                .padding(.top, 5)
            }
            .padding(
                EdgeInsets(
                    top: 12,
                    leading: 24,
                    bottom: 12,
                    trailing: 10
                )
            )
            
            
            HStack{
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(clickedButtonLoad ? Color.white : Color.orange_500)
                        .frame(width: Screen.maxWidth * 0.38, height: 45)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(clickedButtonLoad ? Color.orange_500 : Color.white, lineWidth: 2)
                            HStack {
                                Image(clickedButtonLoad ? "heroicons_map-pin1" : "heroicons_map-pin_white1" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                Text("길찾기")
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(clickedButtonLoad ? Color.orange_500 : Color.white)
                            }
                            .onTapGesture {
                                clickedButtonLoad.toggle()
//                                kakaoNavi()   고치기
                            }
                        }
                }
                .padding(.trailing, 10)
                
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(clickedButtonCall ? Color.white : Color.orange_500)
                        .frame(width: Screen.maxWidth * 0.38, height: 45)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(clickedButtonCall ? Color.orange_500 : Color.white, lineWidth: 2)
                            HStack {
                                
                                Image(clickedButtonCall ?
                                      "Frame_1516" : "Vector")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                Text("전화하기")
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(clickedButtonCall ? Color.orange_500 : Color.white)
                            }
                            .onTapGesture {
                                clickedButtonCall.toggle()
                                detailResultViewModel.callButtonTapped(number: "")   //고치기  //데이터넣기
                            }
                        }
                }
                .padding(.leading, 10)
                
                
                
            }
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 24,
                    bottom: 24,
                    trailing: 32
                )
            )
            
            VStack{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.lightGray)
                    .frame(width: Screen.maxWidth * 0.8, height: 130)
                    .overlay{
                        VStack(alignment: .leading){
                            VStack{
                                Text("세부 일정")
                                    .font(.poppins(.NanumSquareOTF_acB, size: 16))           // .font(.system(size: 16)) //.fontWeight(.bold)
                                    .padding(
                                        EdgeInsets(
                                            top: 20,
                                            leading: 0,
                                            bottom: 16,
                                            trailing: 10
                                        )
                                    )
                            }
                            VStack{
                                Text("오전: 협재해수욕장에서 아이와 해수욕을 즐깁니다.")   //  .font(.system(size: 14))  //.fontWeight(.regular)
                                    .font(.poppins(.Pretendard_Regular, size: 12))
                            }
                            .padding(.bottom, 18)
                            Spacer()
                        }
                        .padding([.leading,.trailing],16)
                        .offset(x: -15)
                        
                    }
            }
            .padding(
                EdgeInsets(
                    top: 12,
                    leading: 24,
                    bottom: 12,
                    trailing: 24
                )
            )
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("일정상세")
                //                            .font(.system(size: 20))
                //                            .fontWeight(.bold)
                    .font(.poppins(.NanumSquareOTF_acEB, size: 20))
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("BackPageIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                }
            }
            
        }
    }

}

//#Preview {
//    DetailResultListView()
//}
