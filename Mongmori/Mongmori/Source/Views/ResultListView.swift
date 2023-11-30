//
//  ResultListView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct ResultListView: View {
    var index: Int
    var str : String
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .opacity(0.5)
                .frame(width: Screen.maxWidth * 0.8, height: Screen.maxHeight * 0.1)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.orange_500)
                    HStack{
                        Image("MapMarker")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.leading, 20)
                        
                        Text("\(str)")
                            .font(.poppins(.Pretendard_Regular, size: 18))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                            .truncationMode(.tail)
                        
                        NavigationLink {
                            DetailResultListView(index: index)
                        } label: {
                            Image("ChevronRightIcon_orange_f")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 20)
                        }
                    }
                }

        }
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


//#Preview {
//    ResultListView(index: "")
//}

