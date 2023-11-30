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
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: Screen.maxWidth * 0.80, height: Screen.maxHeight * 0.1)
                .overlay {
                    HStack{
                        Image("MapMarker")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 20)
                        Text("오전: 애월해안도로")
                            .font(.system(size: 17))
                        NavigationLink {
                            DetailResultListView()
                        } label: {
                            Image("ChevronRightIcon_orange_f")
                                .resizable()
                                .frame(width: 30, height: 30)
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


#Preview {
    ResultListView(index: 2)
}

