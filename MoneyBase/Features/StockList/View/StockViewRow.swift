//
//  StockView.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 18/07/25.
//

import SwiftUI

struct StockViewRow: View {
    let stock: StockEntity
    
    var body: some View {
        HStack(spacing: DesignSystem.Spacing.xs) {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.xxxs) {
                Text(stock.symbol)
                    .font(DesignSystem.Typography.boldMedium)
                    .foregroundColor(DesignSystem.Colors.textPrimary)
                
                Text(stock.name)
                    .font(DesignSystem.Typography.thinSmall)
                    .foregroundColor(DesignSystem.Colors.textSecondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: DesignSystem.Spacing.xxxs) {
                Text(stock.lastsale)
                    .font(DesignSystem.Typography.boldMedium)
                    .foregroundColor(DesignSystem.Colors.textSecondary)
                
                Text(stock.pctchange)
                    .font(DesignSystem.Typography.boldSmall)
                    .foregroundColor(
                        stock.isPorcentNegative ?
                        DesignSystem.Colors.stockNegative : 
                            DesignSystem.Colors.stockPositive
                    )
            }
        }
        .padding(DesignSystem.Spacing.sm)
    }
}

#Preview {
    VStack(spacing: DesignSystem.Spacing.xxs) {
        StockViewRow(stock: .preview)
        StockViewRow(stock: .preview)
    }
    .padding()
    .background(DesignSystem.Colors.backgroundPrimary)
}
