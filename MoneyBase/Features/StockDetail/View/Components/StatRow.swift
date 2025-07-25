//
//  StatRow.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 24/07/25.
//

import SwiftUI

struct StatRow: View {
    let label: String
    let value: String
    let color: Color?
    
    init(label: String, value: String, color: Color? = nil) {
        self.label = label
        self.value = value
        self.color = color
    }
    
    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(DesignSystem.Colors.textSecondary)
            Spacer()
            Text(value)
                .font(.body.weight(.semibold))
                .foregroundColor(color ?? DesignSystem.Colors.textPrimary)
        }
    }
}

#Preview {
    StatRow(
        label: "Test",
        value: "100",
        color: .blue
    )
}
