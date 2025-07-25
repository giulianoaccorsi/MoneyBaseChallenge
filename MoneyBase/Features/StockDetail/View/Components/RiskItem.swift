//
//  RiskItem.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 24/07/25.
//

import SwiftUI

struct RiskItem: View {
    let title: String
    let risk: Int
    let icon: String
    
    init(title: String, risk: Int, icon: String) {
        self.title = title
        self.risk = risk
        self.icon = icon
    }
    
    private var riskLevel: RiskLevel {
        switch risk {
        case 0...3: return .low
        case 4...6: return .medium
        default: return .high
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundColor(riskLevel.riskColors.primary)
                
                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundColor(DesignSystem.Colors.textSecondary)
            }
            
            HStack {
                VStack {
                    Text("\(risk)")
                        .font(.title3.weight(.bold))
                        .foregroundColor(riskLevel.riskColors.primary)
                    
                    Text(riskLevel.displayName)
                        .font(.caption2.weight(.medium))
                        .foregroundColor(riskLevel.riskColors.primary)
                        .padding(DesignSystem.Spacing.xxxs)
                        .background(
                            Capsule()
                                .fill(riskLevel.riskColors.background)
                        )
                }
            }
        }
        .padding(DesignSystem.Spacing.xs)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

enum RiskLevel {
    case low, medium, high
    
    var displayName: LocalizedStringKey {
        switch self {
        case .low: return .riskLevelLow
        case .medium: return .riskLevelMedium
        case .high: return .riskLevelHigh
        }
    }
    
    var riskColors: (primary: Color, background: Color) {
        switch self {
        case .low: return (.green, .green.opacity(0.1))
        case .medium: return (.orange, .orange.opacity(0.1))
        case .high: return (.red, .red.opacity(0.1))
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        RiskItem(title: "Audit Risk", risk: 3, icon: "doc.text.magnifyingglass")
        RiskItem(title: "Overall Risk", risk: 7, icon: "shield.lefthalf.filled")
    }
    .padding()
}
