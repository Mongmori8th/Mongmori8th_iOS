//
//  Modifiers.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

import SwiftUI
import Foundation

// MARK: - 회색 테두리 버튼에 사용될 모디파이어.

struct GreyBorderedButtonModifier: ViewModifier {
    var textColor = Color.black
    var borderColor = Color.gray.opacity(0.8)
    var backgroundColor = Color.white
    var lineWidth: CGFloat = 0.5

    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
            .background(backgroundColor)
    }
}

// MARK: - 대표색 테두리 버튼에 사용될 모디파이어.

struct AccentColorBorderedButtonModifier: ViewModifier {
    var textColor = Color("AccentColor")
    var borderColor = Color("AccentColor")
    var backgroundColor = Color.white
    var lineWidth: CGFloat = 1.5

    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
            .background(backgroundColor)
    }
}

// MARK: - 배경색이 들어간 버튼에 사용될 모디파이어.
///버튼 크기에 따라 cornerRadius를 5, 10 으로 구분지어 사용하면 된다

struct ColoredButtonModifier: ViewModifier {
    var color: Color = Color("AccentColor")
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .bold()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .padding(.horizontal)
    }
}

// MARK: - 주문내역 탭의 카드뷰를 만들때 사용하는 모디파이어.

struct PurchaseHistoryCardViewModifier: ViewModifier {
    var textColor = Color.black
    var borderColor = Color("SubColor")
    var backgroundColor = Color.white
    var lineWidth: CGFloat = 1.5

    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
            .background(backgroundColor)
    }
}

// MARK: - 체크박스 모디파이어.

struct CheckBoxModifier: ViewModifier {
    var isCheckedAll: Bool
    func body(content: Content) -> some View {
        content
            .foregroundColor(isCheckedAll ? Color("AccentColor") : .gray)
            .fontWeight(.bold)
    }
}

// MARK: - 피커 모디파이어.

struct PickerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .colorMultiply(.black)
            .background {
                Color.gray.brightness(0.3)
            }
            .cornerRadius(5)
    }
}

// MARK: - 엑스버튼 모디파이어.

struct XButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.secondary)
    }
}

// MARK: - 구매선택 모디파이어.

struct PurchaseSectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background {
                Color.gray.brightness(0.4)
            }
    }
}

// MARK: - 옵션텍스트 모디파이어.

struct OptionTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .foregroundColor(.secondary)
    }
}


// MARK: - 배경색이 들어간 버튼에 사용될 모디파이어. maxWidth가 .infinity
///버튼 크기에 따라 cornerRadius를 5, 10 으로 구분지어 사용하면 된다

struct MaxWidthColoredButtonModifier: ViewModifier {
    var color: Color = Color("AccentColor")
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .bold()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
    }
}

// MARK: - Modifier : 배경이 투명한 TextField 속성
struct ClearTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .font(.subheadline)
            .padding(.horizontal, 20)
    }
}

// MARK: - Modifier : TextField 아래 밑줄을 표현하기 위한 Rectangle 속성
struct TextFieldUnderLineRectangleModifier: ViewModifier {
    let stateTyping: Bool
    var padding: CGFloat = 20
    func body(content: Content) -> some View {
        content
            .frame(height: 1)
            .foregroundColor(stateTyping ? .accentColor : .gray)
            .padding(.horizontal, padding)
    }
}

// MARK: - 제품 상세 페이지의 버튼들에 대한 Modifier

struct ProductButtonModifier: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
}

struct CategoryButtonModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .frame(width:160 , height: 160)
            .background(color)
            .cornerRadius(20)
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("SubColor"), lineWidth: 2)
            }
    }
}

struct ContentButtonModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .frame(width:160 , height: 160)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 3, y: 2)
    }
}


// MARK: - Modifier : 배경이 회색인 TextField 속성
struct GrayBackgroundTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("bgColor"))
            .cornerRadius(15)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .font(.subheadline)
    }
}


struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                            .padding(.vertical, 10)
//                            .padding(.trailing, 10)
                    }
                )
            }
        }
    }
}


struct PasswordAlertModifier: ViewModifier {
    @Binding var showingAlert: Bool
    @Binding var password: String
    @Binding var password_2: String
    func body(content: Content) -> some View {
        content
            .alert("비밀번호를 다시 입력해주세요", isPresented: $showingAlert) {
                Button("Ok") {
                    password = ""
                    password_2 = ""
                }
            }
    }
}
