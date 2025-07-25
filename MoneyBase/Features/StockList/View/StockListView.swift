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
        NavigationStack {
            VStack(spacing: DesignSystem.Spacing.none) {
                content
            }
            .navigationTitle(.navigationTitle)
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
            LoadingView()
            
        case .loaded(let stocks):
            stocksList(stocks: stocks)
            
        case .error(let error):
            ErrorView(error: error) {
                viewModel.refreshStocks()
            }
        }
    }
    
    private func stocksList(stocks: [StockEntity]) -> some View {
        VStack(spacing: DesignSystem.Spacing.none) {
            List {
                ForEach(viewModel.filteredStocks) { stock in
                    NavigationLink {
                        StockDetailView(
                            viewModel: StockDetailViewModel(stock: stock)
                        )
                    } label: {
                        StockViewRow(stock: stock)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .searchable(text: $viewModel.searchText, prompt: Text(.searchPlaceholder))
            .refreshable {
                viewModel.refreshStocks()
            }
            .disabled(viewModel.isUpdating)
            .toolbar {
                ToolbarItemGroup {
                    Text("\(AppStrings.UI.updatedLabel) \(viewModel.lastUpdate.formatted(date: .omitted, time: .standard))")
                        .font(DesignSystem.Typography.thinSmall)
                        .foregroundColor(DesignSystem.Colors.textSecondary)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack(spacing: DesignSystem.Spacing.xxs) {
                        Button {
                            viewModel.goToPreviousPage()
                        } label: {
                            Image(
                                systemName: AppStrings.SystemImages.chevronLeft
                            )
                                .font(DesignSystem.Typography.thinSmall)
                                .foregroundColor(viewModel.canGoToPreviousPage ?
                                                 DesignSystem.Colors.primary :
                                                    DesignSystem.Colors.textDisabled)
                        }
                        .disabled(!viewModel.canGoToPreviousPage)
                        
                        Text("\(viewModel.currentPage)")
                            .font(DesignSystem.Typography.thinSmall)
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
}

#Preview {
    NavigationStack {
        StockListView(viewModel: StockListViewModel(useCase: MockStockUseCase()))
    }
}
