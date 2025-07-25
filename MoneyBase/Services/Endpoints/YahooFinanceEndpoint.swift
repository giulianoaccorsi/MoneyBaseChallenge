//
//  Endpoints.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 20/07/25.
//

import Foundation

enum YahooFinanceEndpoint {
    case getAllStocks(page: Int)
    case getStockDetail(symbol: String)
}

extension YahooFinanceEndpoint: APIEndpointProtocol {
    var apiVersion: String {
        switch self {
        case .getAllStocks:
            "v2/"
        case .getStockDetail:
            "v1/"
        }
    }
    
    var baseURL: String {
        Constants.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllStocks, .getStockDetail:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .getAllStocks:
            "markets/tickers"
        case .getStockDetail:
            "markets/stock/modules"
        }
    }
    
    var headers: [String: String] {
        return ["x-rapidapi-key": APIConfigurator.apiKey,
                "x-rapidapi-host": APIConfigurator.apiHost]
    }
    
    var urlParams: [String: any CustomStringConvertible] {
        switch self {
        case .getAllStocks(let page):
            return ["page": page, "type": "STOCKS"]
        case .getStockDetail(let symbol):
            return ["ticker": symbol, "module": "asset-profile"]
        }
    }
    
    var body: HTTPBody? {
        return nil
    }
}
