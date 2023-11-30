//
//  TestView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKNavi


struct TestView: View {
    let destination = NaviLocation(name: "카카오판교오피스", x: "321286", y: "533707")
    let viaList = [NaviLocation(name: "판교역 1번출구", x: "321525", y: "532951")]

    
    var body: some View {
        Text("Hello, World!")
//            .font(.poppins(.NanumSquareOTF_acB, size: 18))
        Button {
            openKakaoNavi()
        } label: {
            Text("@@")
        }

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
        guard let navigateUrl = NaviApi.shared.navigateUrl(destination: destination, viaList: viaList) else {
            return
        }
        if UIApplication.shared.canOpenURL(navigateUrl) {
            UIApplication.shared.open(navigateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NaviApi.webNaviInstallUrl, options: [:], completionHandler: nil)
        }


    }
}

#Preview {
    TestView()
}
