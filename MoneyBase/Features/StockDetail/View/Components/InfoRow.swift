//
//  InfoRow.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 24/07/25.
//

import SwiftUI

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xxxs) {
            Text(label)
                .font(.caption.weight(.medium))
                .foregroundColor(DesignSystem.Colors.textSecondary)
            Text(value)
                .font(.body)
                .foregroundColor(DesignSystem.Colors.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    InfoRow(
        label: "Info",
        value: "10"
    )
}
