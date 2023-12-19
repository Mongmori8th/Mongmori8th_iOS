//
//  Constants.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

import Foundation

import SwiftUI

struct Screen {
    static let maxWidth = UIScreen.main.bounds.width
    static let maxHeight = UIScreen.main.bounds.height
}


// 키보드가 나타날 때 뷰를 함께 올리는 확장
extension View {
    func keyboardAwarePadding(paddingHeight: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: KeyboardAwareModifier(paddingHeight: paddingHeight))
    }
}

struct KeyboardAwareModifier: ViewModifier {
    @State private var currentHeight: CGFloat = 0
    let paddingHeight: CGFloat

    init(paddingHeight: CGFloat) {
        self.paddingHeight = paddingHeight
    }

    func body(content: Content) -> some View {
        content
            .padding(.bottom, currentHeight + paddingHeight)
            .onAppear(perform: subscribeToKeyboardEvents)
    }

    private func subscribeToKeyboardEvents() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.currentHeight = keyboardSize.height
            }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.currentHeight = 0
        }
    }
}





