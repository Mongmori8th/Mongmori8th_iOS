//
//  TestLottieView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//
import UIKit
import SwiftUI
import Lottie

struct TestLottieView: View {
    var body: some View {
        LottieViewManager(filename: "loadingLottie")

    }
}

#Preview {
    TestLottieView()
}

