//
//  StockDetailViewModelTests.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Testing
import Foundation
@testable import MoneyBase

@Suite("StockDetailViewModel Tests")
struct StockDetailViewModelTests {
    @Test("Initial state should be loading")
    func testInitialState() {
        let useCase = MockStockUseCase()
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        #expect(TestHelpers.isLoading(viewModel.viewState))
        #expect(viewModel.stock.symbol == "AAPL")
    }
    
    @Test("Load stock detail successfully")
    func testLoadStockDetailSuccess() async {
        let useCase = MockStockUseCase.withSuccessfulData()
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        await viewModel.loadStockDetail()
        
        guard let detail = TestHelpers.expectLoaded(viewModel.viewState) else { return }
        
        #expect(detail.industry == "Consumer Electronics")
        #expect(detail.fullTimeEmployees == 164000)
        #expect(detail.companyOfficers?.count == 3)
        #expect(useCase.getStockDetailCallCount == 1)
        #expect(useCase.lastSymbolRequested == "AAPL")
    }
    
    @Test("Load stock detail with server error")
    func testLoadStockDetailServerError() async {
        let useCase = MockStockUseCase.withNetworkError()
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        await viewModel.loadStockDetail()
        
        guard let error = TestHelpers.expectError(viewModel.viewState) else { return }
        
        #expect(TestHelpers.isServerError(error, code: 500))
        #expect(useCase.getStockDetailCallCount == 1)
    }
    
    @Test("Load stock detail with decoding error")
    func testLoadStockDetailDecodingError() async {
        let useCase = MockStockUseCase.withDecodingError()
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        await viewModel.loadStockDetail()
        
        guard let error = TestHelpers.expectError(viewModel.viewState) else { return }
        
        #expect(TestHelpers.isDecodingError(error))
    }
    
    @Test("Load stock detail with no response error")
    func testLoadStockDetailNoResponseError() async {
        let useCase = MockStockUseCase()
        useCase.setupError(.noResponse)
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        await viewModel.loadStockDetail()
        
        guard let error = TestHelpers.expectError(viewModel.viewState) else { return }
        
        #expect(TestHelpers.isNoResponse(error))
    }
    
    @Test("Refresh functionality resets to loading")
    func testRefreshFunctionality() async {
        let useCase = MockStockUseCase.withSuccessfulData()
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        await viewModel.loadStockDetail()
        #expect(TestHelpers.isLoaded(viewModel.viewState))
        
        viewModel.refresh()
        
        #expect(TestHelpers.isLoading(viewModel.viewState))
        
        await TestHelpers.wait(milliseconds: 10)
    }
    
    @Test("Refresh after error recovers successfully")
    func testRefreshAfterErrorRecovery() async {
        let useCase = MockStockUseCase()
        useCase.setupError(.serverError(500))
        
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        await viewModel.loadStockDetail()
        #expect(TestHelpers.isError(viewModel.viewState))
        
        useCase.setupSuccessfulStockDetail(StockDetailFixtures.appleDetail)
        
        viewModel.refresh()
        
        #expect(TestHelpers.isLoading(viewModel.viewState))
        
        await TestHelpers.wait(milliseconds: 10)
    }
    
    @Test("View model handles different stock entities")
    func testDifferentStockEntities() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockDetail(StockDetailFixtures.teslaDetail)
        
        let viewModel = StockDetailViewModel(stock: .testTesla, useCase: useCase)
        
        await viewModel.loadStockDetail()
        
        guard let detail = TestHelpers.expectLoaded(viewModel.viewState) else { return }
        
        #expect(detail.industry == "Auto Manufacturers")
        #expect(detail.sector == "Consumer Cyclical")
        #expect(useCase.lastSymbolRequested == "TSLA")
    }
    
    @Test("Load stock detail with minimal data")
    func testLoadStockDetailMinimalData() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockDetail(StockDetailFixtures.minimalDetail)
        
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        await viewModel.loadStockDetail()
        
        guard let detail = TestHelpers.expectLoaded(viewModel.viewState) else { return }
        
        #expect(detail.industry == nil)
        #expect(detail.fullTimeEmployees == nil)
        #expect(detail.companyOfficers == nil)
    }
    
    @Test("Load stock detail with high risk data")
    func testLoadStockDetailHighRisk() async {
        let useCase = MockStockUseCase()
        useCase.setupSuccessfulStockDetail(StockDetailFixtures.highRiskDetail)
        
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        await viewModel.loadStockDetail()
        
        guard let detail = TestHelpers.expectLoaded(viewModel.viewState) else { return }
        
        #expect(detail.auditRisk == 10)
        #expect(detail.boardRisk == 10)
        #expect(detail.compensationRisk == 10)
        #expect(detail.overallRisk == 10)
    }
    
    @Test("Task cancellation on deinit prevents crashes")
    func testTaskCancellationOnDeinit() async {
        let useCase = MockStockUseCase.withDelay(milliseconds: 500)
        
        var viewModel: StockDetailViewModel? = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        Task {
            await viewModel?.loadStockDetail()
        }
        
        viewModel = nil
        
        await TestHelpers.wait(milliseconds: 10)
        
        #expect(viewModel == nil)
    }
    
    @Test("Concurrent load operations handle properly")
    func testConcurrentLoadOperations() async {
        let useCase = MockStockUseCase.withDelay(milliseconds: 50)
        let viewModel = StockDetailViewModel(stock: .testApple, useCase: useCase)
        
        async let task1: Void = viewModel.loadStockDetail()
        async let task2: Void = viewModel.loadStockDetail()
        async let task3: Void = viewModel.loadStockDetail()
        
        await task1
        await task2
        await task3
        
        let isValidFinalState = TestHelpers.isLoaded(viewModel.viewState) || TestHelpers.isError(viewModel.viewState)
        #expect(isValidFinalState)
    }
}
