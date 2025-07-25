//
//  StockDetailViewModel.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Foundation

@Observable
final class StockDetailViewModel {
    private(set) var viewState: StockDetailViewState = .loading
    private(set) var stock: StockEntity
    private let useCase: StockUseCaseProtocol
    private var loadingTask: Task<Void, Never>?
    
    init(
        stock: StockEntity,
        useCase: StockUseCaseProtocol = StockUseCase()
    ) {
        self.stock = stock
        self.useCase = useCase
    }
    
    deinit {
        loadingTask?.cancel()
    }
    
    func loadStockDetail() async {
        loadingTask?.cancel()
        viewState = .loading
        
        loadingTask = Task {
            do {
                let detailedEntity = try await useCase.getStockDetail(symbol: stock.symbol)
                guard !Task.isCancelled else { return }
                viewState = .loaded(detailedEntity)
            } catch {
                guard !Task.isCancelled else { return }
                let networkError = (error as? NetworkError) ?? .unknown
                viewState = .error(networkError)
            }
        }
        
        await loadingTask?.value
    }
    
    func refresh() {
        loadingTask?.cancel()
        viewState = .loading
        
        loadingTask = Task {
            await loadStockDetail()
        }
    }
} 
