//
//  DetailResultListView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

// MARK: - 리스트 상세 결과값

struct DetailResultListView: View {
    var body: some View {
        
        VStack(alignment: .leading){
            
            Image("test1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Screen.maxWidth * 0.8 ,height: 250)
            
            Text("제주동문화공원")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.bottom, 7)
            
            Text("제주시 조천읍 남조로 2023")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .padding(.bottom, 4)
            
            Text("나와의 거리 102km")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            
            HStack{
                Button {
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.scrollViewBackGround)
                        .frame(width: Screen.maxWidth * 0.38, height: 35 )
                        .overlay{
                            Text("길안내")
                                .bold()
                                .foregroundColor(.black)
                            
                            
                        }
                }
                
                Button {
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.scrollViewBackGround)
                        .frame(width: Screen.maxWidth * 0.37, height: 35 )
                        .overlay{
                            Text("전화하기")
                                .bold()
                                .foregroundColor(.black)
                            
                            
                        }
                }
            }
            .padding(.bottom, 20)
            
        }
        .padding(.top, 20)
        
        
        Rectangle()
            .fill(Color.black)
            .frame(width: Screen.maxWidth * 0.9 , height: 2)
            .padding(.bottom, 10)
        
        
        VStack(alignment: .leading){
            Text("일정 설명")
                .fontWeight(.bold)
                .font(.title)
                .padding(.bottom, 10)
            
            Text("오후: 애월갯벌 체험과 애월향 산책 \n애월갯벌에서 갯벌 체험후 애월항 산책로에서 휴식")
        }
        
        Spacer()
        
    }
}

#Preview {
    DetailResultListView()
}

