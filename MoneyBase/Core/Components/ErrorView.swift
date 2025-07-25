//
//  Error.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 22/07/25.
//

import SwiftUI

struct ErrorView: View {
    let error: NetworkError
    let retryAction: (() -> Void)?
    
    @State private var isAnimating = false
    
    init(
        error: NetworkError,
        retryAction: (() -> Void)? = nil
    ) {
        self.error = error
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            ZStack {
                Circle()
                    .fill(.orange.opacity(0.1))
                    .frame(width: 120, height: 120)
                
                Circle()
                    .fill(.orange.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                    .animation(
                        .easeInOut(duration: 2.0).repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                
                Image(systemName: AppStrings.SystemImages.errorTriangle)
                    .font(DesignSystem.Typography.boldLarge)
                    .foregroundStyle(.orange)
                    .scaleEffect(isAnimating ? 1.05 : 1.0)
                    .animation(
                        .easeInOut(duration: 2.0).repeatForever(autoreverses: true),
                        value: isAnimating
                    )
            }
            
            VStack(spacing: DesignSystem.Spacing.xs) {
                Text(.errorTitle)
                    .font(DesignSystem.Typography.boldMedium)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                
                Text(error.errorDescription ?? "")
                    .font(DesignSystem.Typography.thinSmall)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, DesignSystem.Spacing.md)
            }
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    HStack(spacing: DesignSystem.Spacing.xxs) {
                        Image(systemName: AppStrings.SystemImages.clockWise)
                        Text(.tryAgainButton)
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, DesignSystem.Spacing.lg)
                    .padding(.vertical, DesignSystem.Spacing.xs)
                    .background(
                        Capsule()
                            .fill(.orange.gradient)
                    )
                }
            }
        }
        .padding(DesignSystem.Spacing.lg)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    ErrorView(error: .invalidURL) {
    }
}
