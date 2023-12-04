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
    func keyboardAwarePadding() -> some View {
        ModifiedContent(
            content: self,
            modifier: KeyboardAwareModifier()
        )
    }
}

struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, max(0, keyboardHeight))
            .onAppear(perform: subscribeToKeyboardEvents)
    }

    private func subscribeToKeyboardEvents() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { notification in
            handleKeyboard(notification: notification, isShowing: true)
        }

        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main
        ) { notification in
            handleKeyboard(notification: notification, isShowing: false)
        }
    }

    private func handleKeyboard(notification: Notification, isShowing: Bool) {
        guard let userInfo = notification.userInfo else { return }

        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0

        withAnimation {
            self.keyboardHeight = isShowing ? keyboardHeight : 0
        }
    }
}
