//
//  LottieViewManager.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

import Foundation
import SwiftUI
import Lottie
import UIKit

struct LottieViewManager: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    var filename: String
    var animationView = LottieAnimationView()
    
    
    class Coordinator: NSObject {
        var parent: LottieViewManager
        
        init(_ animationView: LottieViewManager) {
            self.parent = animationView
            super.init()
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieViewManager>) -> UIView {
        let view = UIView()
        
        //lottie 구현뷰
        animationView.animation = LottieAnimation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        

        animationView.loopMode = .loop
        animationView.play()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieViewManager>) {
        
    }
}
