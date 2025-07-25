//
//  StockUseCase.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 20/07/25.
//

import Foundation

protocol StockUseCaseProtocol {
    func getAllStocks(page: Int) async throws -> [StockEntity]
    func getStockDetail(symbol: String) async throws -> StockDetailEntity
}

struct StockUseCase: StockUseCaseProtocol {
    private let networkManager: NetworkServiceProtocol
    
    init(networkManager: NetworkServiceProtocol = NetworkService.shared) {
        self.networkManager = networkManager
    }
    
    func getAllStocks(
        page: Int
    ) async throws -> [StockEntity] {
        let endpoint = YahooFinanceEndpoint.getAllStocks(page: page)
        let response = try await networkManager.request(endpoint, responseType: ResultResponse.self)
        return response.body
    }
    
    func getStockDetail(
        symbol: String
    ) async throws -> StockDetailEntity {
        let endpoint = YahooFinanceEndpoint.getStockDetail(symbol: symbol)
        let response = try await networkManager.request(endpoint, responseType: StockDetailResult.self)
        return response.body
    }
}

struct MockStockUseCase: StockUseCaseProtocol {
    func getAllStocks(page: Int) async throws -> [StockEntity] {
        try await Task.sleep(nanoseconds: 500_000_000)
        return loadMockStocks()
    }
    
    func getStock(id: Int) async throws -> StockEntity {
        return StockEntity.preview
    }
    
    func getStockDetail(symbol: String) async throws -> StockDetailEntity {
        try await Task.sleep(nanoseconds: 500_000_000)
        return loadMockDetailStocks()
    }
    
    private func loadMockStocks() -> [StockEntity] {
        guard let url = Bundle.main.url(
            forResource: "MockStocksData",
            withExtension: "json"
        ),
              let data = try? Data(contentsOf: url) else {
            fatalError("Failed to find or load MockStocksData.json")
        }
        
        do {
            let response = try JSONDecoder().decode(
                ResultResponse.self,
                from: data
            )
            return response.body
        } catch {
            fatalError("Failed to decode MockStocksData.json: \(error)")
        }
    }
    
    private func loadMockDetailStocks() -> StockDetailEntity {
        guard let url = Bundle.main.url(
            forResource: "MockStockDetailData",
            withExtension: "json"
        ),
              let data = try? Data(contentsOf: url) else {
            fatalError("Failed to find or load MockStocksData.json")
        }
        
        do {
            let response = try JSONDecoder().decode(StockDetailResult.self, from: data)
            return response.body
        } catch {
            fatalError("Failed to decode MockStocksData.json: \(error)")
        }
    }
}
