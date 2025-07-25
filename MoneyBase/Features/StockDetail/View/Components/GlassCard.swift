//
//  GlassCard.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 24/07/25.
//

import SwiftUI

struct GlassCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundColor(DesignSystem.Colors.textPrimary)
            
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(DesignSystem.Spacing.lg)
        .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.15), lineWidth: 1)
        )
    }
}

#Preview {
    GlassCard(title: "Glass Card") {
        Text("Hello, World!")
    }
}
