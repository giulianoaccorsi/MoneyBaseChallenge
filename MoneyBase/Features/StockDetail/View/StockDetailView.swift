//
//  StockDetailView.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 24/07/25.
//

import SwiftUI

struct StockDetailView: View {
    @State private var viewModel: StockDetailViewModel
    @State private var selectedTab: DetailTab = .overview
    
    init(
        viewModel: StockDetailViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .navigationTitle(.stockDetails)
            .navigationBarTitleDisplayMode(.large)
            .task {
                await viewModel.loadStockDetail()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .loading:
            LoadingView()
            
        case .loaded(let detailEntity):
            stockDetailView(detailEntity: detailEntity)
            
        case .error(let error):
            ErrorView(error: error) {
                viewModel.refresh()
            }
        }
    }
    
    private func stockDetailView(detailEntity: StockDetailEntity) -> some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.md) {
                headerCard(detailEntity: detailEntity)
                
                tabSelector
                
                Group {
                    switch selectedTab {
                    case .overview:
                        overviewContent(detailEntity: detailEntity)
                    case .company:
                        companyContent(detailEntity: detailEntity)
                    case .leadership:
                        leadershipContent(detailEntity: detailEntity)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: selectedTab)
            }
            .padding(DesignSystem.Spacing.lg)
        }
    }
    
    private func headerCard(detailEntity: StockDetailEntity) -> some View {
        VStack(spacing: DesignSystem.Spacing.xs) {
            VStack(spacing: DesignSystem.Spacing.sm) {
                Text(viewModel.stock.symbol)
                    .font(DesignSystem.Typography.boldExtraLarge)
                    .foregroundStyle(
                        DesignSystem.Colors.primary)
                
                Text(viewModel.stock.name)
                    .multilineTextAlignment(.center)
                    .font(DesignSystem.Typography.boldMedium)
                    .foregroundColor(DesignSystem.Colors.textPrimary)
                
                if let industry = detailEntity.industry {
                    Text(industry)
                        .font(.caption.weight(.medium))
                        .padding(DesignSystem.Spacing.xxs)
                        .background(.ultraThinMaterial, in: Capsule())
                        .foregroundColor(DesignSystem.Colors.textSecondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(DesignSystem.Spacing.xl)
        .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 24))
    }
    
    private var tabSelector: some View {
        HStack {
            ForEach(DetailTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    Text(tab.title)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(selectedTab == tab ? .white : DesignSystem.Colors.textSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, DesignSystem.Spacing.xs)
                        .background(
                            selectedTab == tab ?
                            DesignSystem.Colors.primary.opacity(0.8) :
                                Color.clear,
                            in: RoundedRectangle(cornerRadius: 12)
                        )
                }
            }
        }
        .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
    
    @ViewBuilder
    private func overviewContent(detailEntity: StockDetailEntity) -> some View {
        marketMetricsCard(detailEntity: detailEntity)
        
        if let summary = detailEntity.longBusinessSummary {
            businessSummaryCard(summary: summary)
        }
        
        keyStatsCard(detailEntity: detailEntity)
    }
    
    @ViewBuilder
    private func companyContent(detailEntity: StockDetailEntity) -> some View {
        companyInfoCard(detailEntity: detailEntity)
        
        contactInfoCard(detailEntity: detailEntity)
        
        if detailEntity.auditRisk != nil {
            riskAssessmentCard(detailEntity: detailEntity)
        }
    }
    
    @ViewBuilder
    private func leadershipContent(detailEntity: StockDetailEntity) -> some View {
        if let officers = detailEntity.companyOfficers, !officers.isEmpty {
            ForEach(officers.prefix(6), id: \.name) { officer in
                officerCard(officer: officer)
            }
        } else {
            Text(.leadershipNotAvailable)
                .font(.body)
                .foregroundColor(DesignSystem.Colors.textSecondary)
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
        }
    }
    
    private func marketMetricsCard(detailEntity: StockDetailEntity) -> some View {
        GlassCard(title: AppStrings.UI.marketInformation) {
            Grid(horizontalSpacing: DesignSystem.Spacing.md,
                 verticalSpacing: DesignSystem.Spacing.md) {
                GridRow {
                    MetricItem(title: AppStrings.UI.marketCap, value: "$\(viewModel.stock.marketCap)")
                    MetricItem(title: AppStrings.UI.employees, value: "\(detailEntity.fullTimeEmployees ?? 0)")
                }
                GridRow {
                    MetricItem(title: AppStrings.UI.sector, value: detailEntity.sector ?? "N/A")
                    MetricItem(title: AppStrings.UI.industry, value: detailEntity.industry ?? "N/A")
                }
            }
        }
    }
    
    private func businessSummaryCard(summary: String) -> some View {
        GlassCard(title: AppStrings.UI.businessOverview) {
            Text(summary)
                .font(DesignSystem.Typography.thinSmall)
                .foregroundColor(DesignSystem.Colors.textPrimary)
                .multilineTextAlignment(.leading)
        }
    }
    
    private func keyStatsCard(detailEntity: StockDetailEntity) -> some View {
        GlassCard(
            title: AppStrings.UI.keyStatistics
        ) {
            VStack(spacing: DesignSystem.Spacing.md) {
                StatRow(
                    label: AppStrings.UI.currentPrice,
                    value: viewModel.stock.lastsale
                )
                StatRow(
                    label: AppStrings.UI.netChange,
                    value: viewModel.stock.netchange,
                    color: viewModel.stock.isPorcentNegative ? DesignSystem.Colors.stockNegative : DesignSystem.Colors.stockPositive
                )
                StatRow(
                    label: AppStrings.UI.percentageChange,
                    value: viewModel.stock.pctchange,
                    color: viewModel.stock.isPorcentNegative ? DesignSystem.Colors.stockNegative : DesignSystem.Colors.stockPositive
                )
            }
        }
    }
    
    private func companyInfoCard(detailEntity: StockDetailEntity) -> some View {
        GlassCard(
            title: AppStrings.UI.companyInformation
        ) {
            VStack(spacing: DesignSystem.Spacing.md) {
                if let address = detailEntity.address1 {
                    InfoRow(
                        label: AppStrings.UI.address,
                        value: "\(address), \(detailEntity.city ?? ""), \(detailEntity.state ?? "")"
                    )
                }
                if let country = detailEntity.country {
                    InfoRow(
                        label: AppStrings.UI.country,
                        value: country
                    )
                }
            }
        }
    }
    
    private func contactInfoCard(detailEntity: StockDetailEntity) -> some View {
        GlassCard(title: AppStrings.UI.contactInformation) {
            VStack(spacing: DesignSystem.Spacing.md) {
                if let phone = detailEntity.phone {
                    InfoRow(
                        label: AppStrings.UI.phone,
                        value: phone
                    )
                }
                if let website = detailEntity.irWebsite,
                   let url = URL(string: website) {
                    Link(destination: url) {
                        HStack {
                            Text(.visitWebSite)
                                .foregroundColor(DesignSystem.Colors.primary)
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                                .foregroundColor(DesignSystem.Colors.primary)
                        }
                    }
                }
            }
        }
    }
    
    private func riskAssessmentCard(detailEntity: StockDetailEntity) -> some View {
        GlassCard(title: AppStrings.UI.riskAssessment) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                RiskItem(
                    title: AppStrings.UI.auditRisk,
                    risk: detailEntity.auditRisk ?? 0,
                    icon: "doc.text.magnifyingglass"
                )
                RiskItem(
                    title: AppStrings.UI.boardRisk,
                    risk: detailEntity.boardRisk ?? 0,
                    icon: "person.3"
                )
                RiskItem(
                    title: AppStrings.UI.compensationRisk,
                    risk: detailEntity.compensationRisk ?? 0,
                    icon: "dollarsign.circle"
                )
                RiskItem(
                    title: AppStrings.UI.overallRisk,
                    risk: detailEntity.overallRisk ?? 0,
                    icon: "shield.lefthalf.filled"
                )
            }
        }
    }
    
    private func officerCard(officer: CompanyOfficer) -> some View {
        HStack {
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 50, height: 50)
                .overlay(
                    Text(officer.initials)
                        .font(.title3.weight(.semibold))
                        .foregroundColor(DesignSystem.Colors.primary)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(officer.name)
                    .font(.headline.weight(.semibold))
                    .foregroundColor(DesignSystem.Colors.textPrimary)
                
                Text(officer.title)
                    .font(.subheadline)
                    .foregroundColor(DesignSystem.Colors.textSecondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            if let age = officer.age {
                Text(.age(Int32(age)))
                    .font(.caption.weight(.medium))
                    .foregroundColor(DesignSystem.Colors.textSecondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.ultraThinMaterial, in: Capsule())
            }
        }
        .padding(DesignSystem.Spacing.lg)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    StockDetailView(
        viewModel: .init(
            stock: .preview,
            useCase: MockStockUseCase()
        )
    )
}
