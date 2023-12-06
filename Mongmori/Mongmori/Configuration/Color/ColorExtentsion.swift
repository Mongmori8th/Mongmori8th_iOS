//
//  ColorExtentsion.swift
//  Mongmori
//
//  Created by 지정훈 on 11/29/23.
//

import Foundation

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
    
    // MARK: - EX)
    static let peach = Color(hex: "#ff8882")
    static let scrollViewBackGround = Color(hex: "#F0F0F0")
    
    static let orange_50 = Color(hex: "#FFF7F0")
    static let orange_100 = Color(hex: "#FEE9D7")
    static let orange_500 = Color(hex: "#F57D14")
    static let lightGray = Color(hex: "#F7F7F7")
    static let lightGray2 = Color(red: 0, green: 0, blue: 0, opacity: 0.03)
    
    
    
    
    
    
    
}
