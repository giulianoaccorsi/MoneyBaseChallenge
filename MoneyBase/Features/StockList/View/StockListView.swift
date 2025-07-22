//
//  ContentView.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 18/07/25.
//

import SwiftUI

struct StockListView: View {
    @State private var viewModel: StockListViewModel
    
    init(viewModel: StockListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: DesignSystem.Spacing.none) {
                content
            }
            .navigationTitle(AppStrings.UI.navigationTitle)
            .background(DesignSystem.Colors.backgroundPrimary)
            .task {
                await viewModel.loadStocks()
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .loading:
            loadingView
            
        case .loaded(let stocks):
            stocksList(stocks: stocks)
            
        case .error(let message):
            errorView(message: message)
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            ProgressView()
                .scaleEffect(1.2)
                .progressViewStyle(CircularProgressViewStyle(tint: DesignSystem.Colors.primary))
            
            Text(AppStrings.UI.loadingMessage)
                .font(DesignSystem.Typography.boldLarge)
                .foregroundColor(DesignSystem.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignSystem.Colors.backgroundPrimary)
    }
    
    private func stocksList(stocks: [StockEntity]) -> some View {
        VStack(spacing: DesignSystem.Spacing.none) {
            List {
                ForEach(viewModel.filteredStocks) { stock in
                    StockViewRow(stock: stock)
                }
            }
            .searchable(text: $viewModel.searchText, prompt: Text(AppStrings.UI.searchPlaceholder))
            .refreshable {
                viewModel.refreshStocks()
            }
            .disabled(viewModel.isUpdating)
            .toolbar {
                ToolbarItemGroup {
                    Text("\(AppStrings.UI.updatedLabel) \(viewModel.lastUpdate.formatted(date: .omitted, time: .standard))")
                        .font(DesignSystem.Typography.thinSmall)
                        .foregroundColor(DesignSystem.Colors.textTertiary)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack(spacing: DesignSystem.Spacing.xxs) {
                        Button {
                            viewModel.goToPreviousPage()
                        } label: {
                            Image(systemName: AppStrings.SystemImages.chevronLeft)
                                .font(DesignSystem.Typography.thinSmall)
                                .foregroundColor(viewModel.canGoToPreviousPage ?
                                              DesignSystem.Colors.primary : 
                                              DesignSystem.Colors.textDisabled)
                        }
                        .disabled(!viewModel.canGoToPreviousPage)
                        
                        Text("\(viewModel.currentPage)")
                            .font(DesignSystem.Typography.thinMedium)
                            .foregroundColor(DesignSystem.Colors.textSecondary)
                            .frame(minWidth: 30)
                        
                        Button {
                            viewModel.goToNextPage()
                        } label: {
                            Image(systemName: AppStrings.SystemImages.chevronRight)
                                .font(DesignSystem.Typography.thinSmall)
                                .foregroundColor(viewModel.canGoToNextPage ?
                                              DesignSystem.Colors.primary : 
                                              DesignSystem.Colors.textDisabled)
                        }
                        .disabled(!viewModel.canGoToNextPage)
                    }
                }
            }
        }
    }
    
    private func errorView(message: String) -> some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Image(systemName: AppStrings.SystemImages.errorTriangle)
                .font(DesignSystem.Typography.boldLarge)
                .foregroundColor(DesignSystem.Colors.warning)
            
            Text(AppStrings.UI.errorTitle)
                .font(DesignSystem.Typography.boldSmall)
                .foregroundColor(DesignSystem.Colors.textPrimary)
            
            Text(message)
                .font(DesignSystem.Typography.boldMedium)
                .foregroundColor(DesignSystem.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, DesignSystem.Spacing.lg)
            
            Button(AppStrings.UI.tryAgainButton) {
                viewModel.refreshStocks()
            }
            .padding(.top, DesignSystem.Spacing.sm)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignSystem.Colors.backgroundPrimary)
    }
}

#Preview {
    StockListView(viewModel: .init())
}
