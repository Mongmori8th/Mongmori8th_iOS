//
//  ResultListView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct ResultListView: View {
    var index: Int
    
    var body: some View { 
        ZStack{            
            // MARK: - 실험코드
            Rectangle()
                .fill(Color.orange)
                .frame(width: 2, height: Screen.maxHeight * 0.15)
                .offset(x: 0, y: 55)
                .zIndex(1)
            VStack{
//                Text("\(changeToString(n: index)) 일정")
//                    .fontWeight(.bold)
//                    .offset(x: -115, y: 15)
                HStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .frame(width: Screen.maxWidth * 0.9, height: Screen.maxHeight * 0.1)
                        .overlay {
                            HStack{
                                VStack(alignment: .leading) {
                                    Text("오전: 애원해안도로와 애원 바다마을 출발하여 애원해안도로를 따라가며 해안 풍경 감상")
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                }
                                .padding(.leading, 25)
                                Spacer()
                                
                                NavigationLink {
                                    DetailResultListView()
                                } label: {
                                    Text(">")
                                        .foregroundStyle(.orange)
                                        .font(.system(size: 17))
                                        .padding(.leading, 10)
                                }

                                
                                Spacer()
                            }
                            
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.orange)
                        )
                        .padding()
                }
                
            }
            .zIndex(2)
            
           
        }
        
        
        
    }
    
    func changeToString(n: Int) -> String{
        switch n{
        case 1:
            return "첫번째"
        case 2:
            return "두번째"
        case 3:
            return "세번째"
        case 4:
            return "네번째"
        case 5:
            return "다섯번째"
        case 6:
            return "여섯번째"
        case 7:
            return "일곱번째"
        case 8:
            return "여덟번째"
        default:
            return "아홉번째"
            
        }
    }
}

//#Preview {
//    TestResultListView()
//}
