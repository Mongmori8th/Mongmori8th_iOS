//
//  TestResultListView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct TestResultListView: View {
    var index: Int
    
    var body: some View {     
        VStack{
            Text("\(changeToString(n: index)) 일정")
                .fontWeight(.bold)
                .offset(x: -115, y: 15)
            HStack {
    //            Circle()
    //                .fill(Color.blue)
    //                .frame(width: 40, height: 40)
    //                .overlay {
    //                    Text("\(index)")
    //                }
    //                .offset(x: 5)
    //                .zIndex(1)

                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 5)
                    .frame(width: Screen.maxWidth * 0.8, height: Screen.maxHeight * 0.07)
                    .overlay {
                        HStack{
                            VStack(alignment: .leading) {
                                Text("호텔 에스-플러스 나고야 사카에")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                                Text("숙소 사카에-오스")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.gray)
                            }
                            .padding(.leading, 10)
                            Spacer()
                        }
                        
                    }
                    .padding()
            }
            .offset(x: 5)
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
