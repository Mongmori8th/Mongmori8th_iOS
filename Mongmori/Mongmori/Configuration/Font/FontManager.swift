//
//  FontManager.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

import Foundation
import SwiftUI

extension Font {
    enum Poppins {
        case NanumSquareOTF_acB
        case NanumSquareOTF_acEB
        case NanumSquareOTF_acR
        case Pretendard_Bold
        case Pretendard_Regular
        case Pretendard_SemiBold
        
        case custom(String)
        
        var value: String {
            switch self {
            case .NanumSquareOTF_acB:
                return "NanumSquareOTF_acB"
            case .NanumSquareOTF_acEB:
                return "NanumSquareOTF_acEB"
            case .NanumSquareOTF_acR:
                return "NanumSquareOTF_acR"
            case .Pretendard_Bold:
                return "Pretendard-Bold"
            case .Pretendard_Regular:
                return "Pretendard_Regular"
            case .Pretendard_SemiBold:
                return "Pretendard_SemiBold"
            case .custom(let name):
                return name
            }
            
        }
    }

    static func poppins(_ type: Poppins, size: CGFloat = 18) -> Font {
        return .custom(type.value, size: size)
    }
}
