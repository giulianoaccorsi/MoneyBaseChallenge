//
//  MetricItem.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 24/07/25.
//

import SwiftUI

struct MetricItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xxxs) {
            Text(title)
                .font(DesignSystem.Typography.boldSmall)
                .foregroundColor(DesignSystem.Colors.textSecondary)
            Text(value)
                .font(DesignSystem.Typography.thinSmall)
                .foregroundColor(DesignSystem.Colors.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    MetricItem(title: "USD", value: "100.00")
}
