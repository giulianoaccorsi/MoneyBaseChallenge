//
//  StockListViewModel.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 18/07/25.
//

import Foundation

@Observable
final class StockListViewModel {
    var searchText = ""
    
    private(set) var viewState: StockListViewState = .loading
    private(set) var currentPage = 1
    private(set) var lastUpdate: Date = .now
    private(set) var isUpdating: Bool = false
    
    private var stocks: [StockEntity] = []
    private var loadingTask: Task<Void, Never>?
    private let useCase: StockUseCaseProtocol
    private var updateTimer: Timer?
    
    var filteredStocks: [StockEntity] {
        if searchText.isEmpty {
            return stocks
        } else {
            return stocks.filter { stock in
                stock.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var canGoToPreviousPage: Bool {
        return currentPage > 1 && !isUpdating
    }
    
    var canGoToNextPage: Bool {
        return !isUpdating
    }
    
    init(useCase: StockUseCaseProtocol = StockUseCase()) {
        self.useCase = useCase
        startAutoUpdate()
    }
    
    deinit {
        loadingTask?.cancel()
        stopAutoUpdate()
    }
    
    func loadStocks() async {
        loadingTask?.cancel()
        loadingTask = Task {
            do {
                let response = try await useCase.getAllStocks(page: currentPage)
                guard !Task.isCancelled else { return }
                stocks = response
                viewState = .loaded(stocks)
                lastUpdate = .now
            } catch {
                guard !Task.isCancelled else { return }
                
                let error = (error as? NetworkError) ?? .unknown
                viewState = .error(error)
            }
        }
        
        await loadingTask?.value
        isUpdating = false
    }
    
    func goToNextPage() {
        guard canGoToNextPage else { return }
        viewState = .loading
        currentPage += 1
        loadingTask = Task {
            await loadStocks()
        }
    }
    
    func goToPreviousPage() {
        guard canGoToPreviousPage else { return }
        currentPage -= 1
        viewState = .loading
        loadingTask = Task {
            await loadStocks()
        }
    }

    func refreshStocks() {
        viewState = .loading
        loadingTask?.cancel()
        stopAutoUpdate()
        loadingTask = Task {
            await loadStocks()
            startAutoUpdate()
        }
    }
    
    func startAutoUpdate() {
        updateTimer = Timer.scheduledTimer(
            withTimeInterval: 8.0,
            repeats: true
        ) { [weak self] _ in
            self?.loadingTask = Task {
                self?.isUpdating = true
                await self?.loadStocks()
            }
        }
    }
    
    func stopAutoUpdate() {
        updateTimer?.invalidate()
        updateTimer = nil
        isUpdating = false
    }
}

