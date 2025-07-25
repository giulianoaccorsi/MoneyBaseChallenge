//
//  StockListViewModelTests.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Testing
import Foundation
@testable import MoneyBase

@Suite("StockListViewModel Tests", .serialized)
struct StockListViewModelTests {
    
    @Test("Initial state should be loading")
    func testInitialState() {
        let useCase = MockStockUseCase()
        let viewModel = StockListViewModel(useCase: useCase)
        
        #expect(TestHelpers.isLoading(viewModel.viewState))
        #expect(viewModel.currentPage == 1)
        #expect(viewModel.searchText.isEmpty)
        #expect(!viewModel.isUpdating)
    }
    
    @Test("Load stocks successfully")
    func testLoadStocksSuccess() async {
        let useCase = MockStockUseCase.withSuccessfulData()
        let viewModel = StockListViewModel(useCase: useCase)
        
        await viewModel.loadStocks()
        
        guard let stocks = TestHelpers.expectLoaded(viewModel.viewState) else { return }
        
        #expect(stocks.count == 2)
        #expect(stocks.first?.symbol == "AAPL")
        #expect(stocks.last?.symbol == "TSLA")
        #expect(!viewModel.isUpdating)
        #expect(useCase.getAllStocksCallCount == 1)
        #expect(useCase.lastPageRequested == 1)
    }
    
    @Test("Load stocks with network error")
    func testLoadStocksNetworkError() async {
        let useCase = MockStockUseCase.withNetworkError()
        let viewModel = StockListViewModel(useCase: useCase)
        
        await viewModel.loadStocks()
        
        guard let error = TestHelpers.expectError(viewModel.viewState) else { return }
        
        #expect(TestHelpers.isServerError(error, code: 500))
        #expect(!viewModel.isUpdating)
    }
    
    @Test("Search functionality - symbol match")
    func testSearchBySymbol() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.searchTestStocks)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        
        viewModel.searchText = "AAPL"
        
        #expect(viewModel.filteredStocks.count == 0)
        #expect(viewModel.filteredStocks.isEmpty)
    }
    
    @Test("Search functionality - name match")
    func testSearchByName() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.searchTestStocks)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        
        viewModel.searchText = "Apple"
        
        #expect(viewModel.filteredStocks.count == 1)
        #expect(viewModel.filteredStocks.first?.name.contains("Apple") == true)
    }
    
    @Test("Search functionality - case insensitive")
    func testSearchCaseInsensitive() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.searchTestStocks)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        
        viewModel.searchText = "apple"
        
        #expect(viewModel.filteredStocks.count == 1)
        #expect(viewModel.filteredStocks.first?.name.lowercased().contains("apple") == true)
    }
    
    @Test("Search functionality - partial match")
    func testSearchPartialMatch() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.searchTestStocks)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        
        viewModel.searchText = "Tes"
        
        #expect(viewModel.filteredStocks.count == 2)
        let hasTestCompany = viewModel.filteredStocks.contains { $0.name.contains("Tesla") }
        #expect(hasTestCompany)
    }
    
    @Test("Search functionality - no results")
    func testSearchNoResults() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.basicStockList)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        
        viewModel.searchText = "NonExistentCompany"
        
        #expect(viewModel.filteredStocks.isEmpty)
    }
    
    @Test("Search functionality - empty search returns all")
    func testSearchEmpty() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.basicStockList)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        
        viewModel.searchText = ""
        
        #expect(viewModel.filteredStocks.count == 3)
    }
    
    @Test("Pagination - next page")
    func testNextPageNavigation() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.basicStockList)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        
        #expect(viewModel.currentPage == 1)
        #expect(viewModel.canGoToNextPage)
        
        viewModel.goToNextPage()
        
        await TestHelpers.wait(milliseconds: 10)
        
        #expect(viewModel.currentPage == 2)
        #expect(useCase.getAllStocksCallCount == 2)
        #expect(useCase.lastPageRequested == 2)
    }
    
    @Test("Pagination - previous page")
    func testPreviousPageNavigation() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.basicStockList)
        
        let viewModel = StockListViewModel(useCase: useCase)
        
        viewModel.goToNextPage()
        await TestHelpers.wait(milliseconds: 10)
        
        #expect(viewModel.currentPage == 2)
        #expect(viewModel.canGoToPreviousPage)
        
        
        viewModel.goToPreviousPage()
        
        await TestHelpers.wait(milliseconds: 10)
        
        #expect(viewModel.currentPage == 1)
        #expect(!viewModel.canGoToPreviousPage)
    }
    
    @Test("Pagination - cannot go to previous page from page 1")
    func testCannotGoToPreviousPageFromPageOne() {
        let useCase = MockStockUseCase()
        let viewModel = StockListViewModel(useCase: useCase)
        
        #expect(viewModel.currentPage == 1)
        #expect(!viewModel.canGoToPreviousPage)
    }
    
    @Test("Pagination - can go to next page when not updating")
    func testCanGoToNextPageWhenNotUpdating() {
        let useCase = MockStockUseCase()
        let viewModel = StockListViewModel(useCase: useCase)
        
        #expect(!viewModel.isUpdating)
        #expect(viewModel.canGoToNextPage)
    }
    
    @Test("Refresh functionality updates last update time")
    func testRefreshFunctionality() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.basicStockList)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        
        let initialLastUpdate = viewModel.lastUpdate
        
        viewModel.refreshStocks()
        
        await TestHelpers.wait(milliseconds: 10)
        
        #expect(viewModel.lastUpdate > initialLastUpdate)
    }
    
    @Test("Auto update can be stopped and started")
    func testAutoUpdateStartStop() {
        let useCase = MockStockUseCase()
        let viewModel = StockListViewModel(useCase: useCase)
        viewModel.stopAutoUpdate()
        
        #expect(viewModel.currentPage == 1)
        
        viewModel.startAutoUpdate()
        
        #expect(viewModel.currentPage == 1)
    }
    
    @Test("Error recovery after failed load")
    func testErrorRecovery() async {
        let useCase = MockStockUseCase()
        useCase.setupError(.noResponse)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        #expect(TestHelpers.isError(viewModel.viewState))
        
        useCase.setupSuccessfulStockList(StockFixtures.basicStockList)
        viewModel.refreshStocks()
        await TestHelpers.wait(milliseconds: 10)
        
        #expect(TestHelpers.isLoaded(viewModel.viewState))
    }
    
    @Test("Concurrent load operations handle properly")
    func testConcurrentLoadOperations() async {
        let useCase = MockStockUseCase.withDelay(milliseconds: 50)
        let viewModel = StockListViewModel(useCase: useCase)
        
        async let task1: Void = viewModel.loadStocks()
        async let task2: Void = viewModel.loadStocks()
        async let task3: Void = viewModel.loadStocks()
        
        await task1
        await task2
        await task3
        
        let isValidFinalState = TestHelpers.isLoaded(viewModel.viewState) || TestHelpers.isError(viewModel.viewState)
        #expect(isValidFinalState)
    }
    
    @Test("Memory cleanup on deinit")
    func testMemoryCleanupOnDeinit() async {
        let useCase = MockStockUseCase.withDelay(milliseconds: 500)
        
        var viewModel: StockListViewModel? = StockListViewModel(useCase: useCase)
        
        Task {
            await viewModel?.loadStocks()
        }
        
        viewModel = nil
        
        await TestHelpers.wait(milliseconds: 10)
        
        #expect(viewModel == nil)
    }
    
    @Test("Last update timestamp accuracy")
    func testLastUpdateTimestampAccuracy() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.basicStockList)
        
        let viewModel = StockListViewModel(useCase: useCase)
        
        let beforeLoad = Date()
        await viewModel.loadStocks()
        let afterLoad = Date()
        
        #expect(viewModel.lastUpdate >= beforeLoad)
        #expect(viewModel.lastUpdate <= afterLoad)
    }
    
    
    @Test("Empty search text variations")
    func testEmptySearchTextVariations() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockList(StockFixtures.basicStockList)
        
        let viewModel = StockListViewModel(useCase: useCase)
        await viewModel.loadStocks()
        
        viewModel.searchText = ""
        #expect(viewModel.filteredStocks.count == 3)
        
        viewModel.searchText = "   "
        #expect(viewModel.filteredStocks.isEmpty)
        
        viewModel.searchText = "\t"
        #expect(viewModel.filteredStocks.isEmpty)
        
        viewModel.searchText = "\n"
        #expect(viewModel.filteredStocks.isEmpty)
    }
} 
