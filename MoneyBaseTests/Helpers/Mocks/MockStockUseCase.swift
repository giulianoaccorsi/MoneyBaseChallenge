//
//  MockStockUseCase.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Foundation
@testable import MoneyBase

final class MockStockUseCase: StockUseCaseProtocol {
    var shouldThrowError = false
    var errorToThrow: NetworkError = .unknown
    var getAllStocksDelay: UInt64 = 0
    var getStockDetailDelay: UInt64 = 0
    var mockStocks: [StockEntity] = []
    var mockStockDetail: StockDetailEntity?
    
    private(set) var getAllStocksCallCount = 0
    private(set) var getStockDetailCallCount = 0
    private(set) var lastPageRequested: Int?
    private(set) var lastSymbolRequested: String?
    
    func getAllStocks(page: Int) async throws -> [StockEntity] {
        getAllStocksCallCount += 1
        lastPageRequested = page
        
        if getAllStocksDelay > 0 {
            try await Task.sleep(nanoseconds: getAllStocksDelay)
        }
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return mockStocks
    }
    
    func getStockDetail(symbol: String) async throws -> StockDetailEntity {
        getStockDetailCallCount += 1
        lastSymbolRequested = symbol
        
        if getStockDetailDelay > 0 {
            try await Task.sleep(nanoseconds: getStockDetailDelay)
        }
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        guard let detail = mockStockDetail else {
            throw NetworkError.noResponse
        }
        
        return detail
    }
    
    func reset() {
        shouldThrowError = false
        errorToThrow = .unknown
        getAllStocksDelay = 0
        getStockDetailDelay = 0
        mockStocks = []
        mockStockDetail = nil
        getAllStocksCallCount = 0
        getStockDetailCallCount = 0
        lastPageRequested = nil
        lastSymbolRequested = nil
    }
    
    func setupSuccessfulStockList(_ stocks: [StockEntity]) {
        shouldThrowError = false
        mockStocks = stocks
    }
    
    func setupSuccessfulStockDetail(_ detail: StockDetailEntity) {
        shouldThrowError = false
        mockStockDetail = detail
    }
    
    func setupError(_ error: NetworkError) {
        shouldThrowError = true
        errorToThrow = error
    }
    
    func setupDelay(getAllStocks: UInt64 = 0, getStockDetail: UInt64 = 0) {
        getAllStocksDelay = getAllStocks
        getStockDetailDelay = getStockDetail
    }
}

extension MockStockUseCase {
    static func withSuccessfulData() -> MockStockUseCase {
        let mock = MockStockUseCase()
        mock.setupSuccessfulStockList([
            StockFixtures.appleStock,
            StockFixtures.teslaStock
        ])
        mock.setupSuccessfulStockDetail(StockDetailFixtures.appleDetail)
        return mock
    }
    
    static func withNetworkError() -> MockStockUseCase {
        let mock = MockStockUseCase()
        mock.setupError(.serverError(500))
        return mock
    }
    
    static func withDecodingError() -> MockStockUseCase {
        let mock = MockStockUseCase()
        mock.setupError(.decodingError(NSError(domain: "test", code: 1)))
        return mock
    }
    
    static func withDelay(milliseconds: UInt64) -> MockStockUseCase {
        let mock = MockStockUseCase()
        let nanoseconds = milliseconds * 1_000_000
        mock.setupDelay(getAllStocks: nanoseconds, getStockDetail: nanoseconds)
        mock.setupSuccessfulStockList([StockFixtures.appleStock])
        mock.setupSuccessfulStockDetail(StockDetailFixtures.appleDetail)
        return mock
    }
}
