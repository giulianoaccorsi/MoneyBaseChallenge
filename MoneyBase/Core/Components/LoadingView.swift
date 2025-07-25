//
//  LoadingView.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 22/07/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            ProgressView()
                .scaleEffect(2.0)
                .progressViewStyle(CircularProgressViewStyle(tint: DesignSystem.Colors.primary))
            
            Text(.loadingMessage)
                .font(DesignSystem.Typography.boldMedium)
                .foregroundColor(DesignSystem.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignSystem.Colors.backgroundPrimary)
    }
}

#Preview {
    LoadingView()
}
