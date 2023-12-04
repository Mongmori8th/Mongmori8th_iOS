//
//  TestResultListView.swift
//  Mongmori
//
//  Created by 지정훈 on 12/5/23.
//

import SwiftUI

struct TestResultListView: View {
    var index: Int
    var str : String
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .opacity(0.5)
                .frame(width: Screen.maxWidth * 0.8, height: 80)
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
