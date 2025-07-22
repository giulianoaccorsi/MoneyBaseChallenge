//
//  StockUseCase.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 20/07/25.
//

import Foundation

protocol StockUseCaseProtocol {
    func getAllStocks(page: Int) async throws -> [StockEntity]
    func getStock(id: Int) async throws -> StockEntity
}

struct StockUseCase: StockUseCaseProtocol {
    private let networkManager: NetworkServiceProtocol
    
    init(networkManager: NetworkServiceProtocol = NetworkService.shared) {
        self.networkManager = networkManager
    }
    
    func getAllStocks(page: Int) async throws -> [StockEntity] {
        let endpoint = YahooFinanceEndpoint.getAllStocks(page: page)
        let response = try await networkManager.request(endpoint, responseType: ResultResponse.self)
        return response.body
        
    }
    
    func getStock(id: Int) async throws -> StockEntity {
        return .init(symbol: "", name: "", lastsale: "", netchange: "", pctchange: "", marketCap: "")
    }
}
