//
//  DesignSystem.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 22/07/25.
//

import SwiftUI

struct DesignSystem {
    // MARK: - Colors
    struct Colors {
        
        // Primary Colors
        static let primary = Color.orange
        static let secondary = Color.gray
        
        // Feedback Colors
        static let warning = Color.orange
        
        // Text Colors
        static let textPrimary = Color.primary
        static let textSecondary = Color.secondary
        static let textTertiary = Color.secondary.opacity(0.6)
        static let textDisabled = Color.secondary.opacity(0.4)
        
        // Background Colors
        static let backgroundPrimary = Color(UIColor.systemBackground)
        
        // Stock specific colors
        static let stockPositive = Color.green
        static let stockNegative = Color.red
    }
    
    // MARK: - Typography
    struct Typography {
        // Bold
        static let boldExtraLarge = Font.system(size: 40, weight: .bold, design: .rounded)
        static let boldLarge = Font.system(size: 36, weight: .bold, design: .rounded)
        static let boldMedium = Font.system(size: 20, weight: .bold, design: .rounded)
        static let boldSmall = Font.system(size: 14, weight: .bold, design: .rounded)
        
        // Thin
        static let thinLarge = Font.system(size: 36, weight: .thin, design: .rounded)
        static let thinMedium = Font.system(size: 20, weight: .thin, design: .rounded)
        static let thinSmall = Font.system(size: 14, weight: .thin, design: .rounded)
        
        // Regular
        static let regularLarge = Font.system(size: 16, weight: .regular, design: .rounded)
        static let regularMedium = Font.system(size: 14, weight: .regular, design: .rounded)
        static let regularSmall = Font.system(size: 12, weight: .regular, design: .rounded)
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let none: CGFloat = 0
        static let xxxs: CGFloat = 4
        static let xxs: CGFloat = 8
        static let xs: CGFloat = 12
        static let sm: CGFloat = 16
        static let md: CGFloat = 24
        static let lg: CGFloat = 32
        static let xl: CGFloat = 48
        static let xxl: CGFloat = 64
        static let xxxl: CGFloat = 80
    }
}
