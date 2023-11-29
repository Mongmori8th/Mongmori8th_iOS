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
        case semibold
        case medium
        case custom(String)
        
        var value: String {
            switch self {
            case .semibold:
                return "Jalnan2"
            case .medium:
                return "Jalnan2"
            case .custom(let name):
                return name
            }
        }
    }

    static func poppins(_ type: Poppins, size: CGFloat = 17) -> Font {
        return .custom(type.value, size: size)
    }
}
