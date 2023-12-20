//
//  ModalLoadingView.swift
//  Mongmori
//
//  Created by 지정훈 on 12/20/23.
//

import SwiftUI

struct ModalLoadingView: View {
    @Binding var showLoading: Bool
    var body: some View {
        VStack{
            Image("loadingImage")
                .resizable()
                .frame(width: 350, height: 350)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            showLoading = false
                        }
                    }
                }
            
    
            
            Spacer()
        }
    }
}

//#Preview {
//    ModalLoadingView()
//}
