//
//  OnboardingView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        Image("onBoarding")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Screen.maxWidth, height: Screen.maxHeight)
            .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}


