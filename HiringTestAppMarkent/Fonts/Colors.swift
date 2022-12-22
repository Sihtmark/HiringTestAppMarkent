//
//  Colors.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-07.
//

import Foundation
import SwiftUI
import UIKit

extension Color {
    public static var appOrange: Color {
        return Color(UIColor(red: 1.000, green: 0.429, blue: 0.304, alpha: 1))
    }
    public static var appBlue: Color {
        return Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1))
    }
    public static var appGrey: Color {
        return Color(UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1))
    }
    public static var appBackground: Color {
        return Color(UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1))
    }
    public static var imageCategory: Color {
        return Color(UIColor(red: 0.702, green: 0.702, blue: 0.765, alpha: 1))
    }
    public static var basketCard: Color {
        return Color(UIColor(red: 0.158, green: 0.156, blue: 0.262, alpha: 1))
    }
    
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255)
    }
}


