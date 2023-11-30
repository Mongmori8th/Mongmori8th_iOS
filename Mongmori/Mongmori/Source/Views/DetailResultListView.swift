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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var clickedButtonLoad: Bool = true
    @State var clickedButtonCall: Bool = true
    
    func callButtonTapped(n: String){
        let tmp = "01063717469"
        let telephone = "tel://"
        let formattedString = telephone + tmp
        //        let formattedString = telephone + numberString
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
        print("url:\(url)")
        
    }
    
    func openKakaoNavi() {
        // 목적지 좌표 설정 (예시 좌표)
        let destinationX = "321286"
        let destinationY = "533707"
        let destinationName = "카카오판교오피스"
        
        // KakaoNavi 앱 URL 생성
        let kakaoNaviURLString = "kakaonavi://?destination=\(destinationY),\(destinationX)&option=1&coord_type=wgs84&name=\(destinationName)"
        
        // URL 객체 생성
        guard let kakaoNaviURL = URL(string: kakaoNaviURLString) else {
            return
        }
        
        // KakaoNavi 앱 열기
        if UIApplication.shared.canOpenURL(kakaoNaviURL) {
            UIApplication.shared.open(kakaoNaviURL, options: [:], completionHandler: nil)
        } else {
            // KakaoNavi 앱이 설치되어 있지 않은 경우, 앱 스토어에서 설치하도록 안내
            let appStoreURLString = "https://apps.apple.com/kr/app/kakaonavi/id417698849"
            if let appStoreURL = URL(string: appStoreURLString) {
                UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
            }
        }
    }
    func openAppStore() {
        // 앱의 iTunes 링크 (예시: KakaoNavi 앱)
        let appStoreURLString = "https://apps.apple.com/kr/app/kakaonavi/id417698849"
        
        // URL 객체 생성
        guard let appStoreURL = URL(string: appStoreURLString) else {
            return
        }
        
        // 앱 스토어 열기
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        }
    }
    func test(){
        let destinationX = "321286"
        let destinationY = "533707"
        let destinationName = "카카오판교오피스"
        let destination = NaviLocation(name: "카카오판교오피스", x: "321286", y: "533707")
        let viaList = [NaviLocation(name: "판교역 1번출구", x: "321525", y: "532951")]
        
        guard let navigateUrl = NaviApi.shared.navigateUrl(destination: destination, viaList: viaList) else {
            return
        }
        if UIApplication.shared.canOpenURL(navigateUrl) {
            UIApplication.shared.open(navigateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NaviApi.webNaviInstallUrl, options: [:], completionHandler: nil)
        }
        
        //
        //    }
        
        
    }
    
    var index: Int
    
    var body: some View {
        VStack{
            
            
            if index == 1 {
                Image("detailImage1")
                    .resizable()
                //                    .aspectRatio(contentMode: .fit)
                    .frame(width: Screen.maxWidth ,height: 250)
                
                VStack(alignment: .leading){
                    Text("협재해수욕장")
                        .font(.poppins(.NanumSquareOTF_acEB, size: 20))
                        .padding([.top,.bottom], 15)
                    
                    HStack{
                        Image("IntelliSenseEventIcon_final1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20,height: 20)
                            .offset(y: -3)
                        Text("제주특별자치도 제주시 한림읍 한림로 329-10")
                            .font(.poppins(.Pretendard_Regular, size: 16))
                            .padding(.bottom, 4)
                        Spacer()
                    }
                    
                    HStack{
                        Image("IntelliSenseEventIcon_final1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20,height: 20)
                            .offset(y: -8)
                        
                        Text("나와의 거리 16km")
                            .font(.poppins(.Pretendard_Regular, size: 16))
                            .padding(.bottom, 20)
                        Spacer()
                    }.padding(.bottom, 12)
                    
                }
                .padding([.leading] ,40)
            }
            else if index == 3{
                Image("detailImage2")
                    .resizable()
                //                    .aspectRatio(contentMode: .fit)
                    .frame(width: Screen.maxWidth ,height: 250)
                
                VStack(alignment: .leading){
                    Text("성산일출봉")
                        .font(.poppins(.NanumSquareOTF_acEB, size: 20))
                        .padding(.bottom, 7)
                    
                    HStack{
                        Image("IntelliSenseEventIcon_final1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20,height: 20)
                            .offset(y: -3)
                        Text("제주 서귀포시 성산읍 성산리 1")
                            .font(.poppins(.Pretendard_Regular, size: 16))
                            .padding(.bottom, 4)
                        Spacer()
                    }
                    
                    HStack{
                        Image("IntelliSenseEventIcon_final1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20,height: 20)
                            .offset(y: -8)
                        
                        Text("나와의 거리 109km")
                            .font(.poppins(.Pretendard_Regular, size: 16))
                            .padding(.bottom, 20)
                        Spacer()
                    }
                    
                }
                .padding([.leading] ,40)
            }
            HStack{
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(clickedButtonLoad ? Color.white : Color.orange_500)
                        .frame(width: Screen.maxWidth * 0.38, height: 35)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(clickedButtonLoad ? Color.orange_500 : Color.white, lineWidth: 2)
                            HStack {
                                Image(clickedButtonLoad ? "heroicons_map-pin1" : "heroicons_map-pin_white1" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                Text("길찾기")
                                    .bold()
                                    .foregroundColor(clickedButtonLoad ? Color.orange_500 : Color.white)
                            }
                            .onTapGesture {
                                clickedButtonLoad.toggle()
                                openKakaoNavi()
                                openAppStore()
                                test()
                            }
                        }
                }
                .padding(.trailing, 5)
                
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(clickedButtonCall ? Color.white : Color.orange_500)
                        .frame(width: Screen.maxWidth * 0.38, height: 35)
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
                                    .bold()
                                    .foregroundColor(clickedButtonCall ? Color.orange_500 : Color.white)
                            }
                            .onTapGesture {
                                clickedButtonCall.toggle()
                                callButtonTapped(n: "")
                            }
                        }
                }
                .padding(.leading, 5)
                
                
                
            }
            .padding(.bottom, 45)
            .navigationBarBackButtonHidden(true)
            .padding(.top, 10)
            
            
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color.lightGray)
                .frame(width: Screen.maxWidth * 0.8, height: 130)
                .shadow(color: Color.black.opacity(0.2), radius: 3, y: 2)
                .overlay{
                    VStack(alignment: .leading){
                        Text("세부 일정")
                            .font(.poppins(.NanumSquareOTF_acB, size: 16))
                            .padding(.bottom, 12)
                        if index == 1{
                            Text("오전: 협재해수욕장에서 아이와 해수욕을 즐깁니다.")
                                .font(.poppins(.Pretendard_Regular, size: 12))
                        }else if index == 3{
                            Text("오후: 성산일출봉을 방문하여 가족과 함께 하이킹을 즐길 수 있습니다.")
                                .font(.poppins(.Pretendard_Regular, size: 12))
                        }
                        //                            Text("오후: 애월갯벌 체험과 애월향 산책 \n애월갯벌에서 갯벌 체험후 애월항 산책로에서 휴식")
                    }
                    .offset(x: -15)
                    
                }
            
            Spacer()
            
            
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("일정상세")
                            .font(.poppins(.NanumSquareOTF_acEB, size: 20))
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
    //#Preview {
    //    DetailResultListView()
    //}
}
