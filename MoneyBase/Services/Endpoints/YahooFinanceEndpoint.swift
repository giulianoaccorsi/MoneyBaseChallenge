//
//  Endpoints.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 20/07/25.
//

import Foundation

enum YahooFinanceEndpoint {
    case getAllStocks(page: Int)
    case getStockDetail(id: String)
}

extension YahooFinanceEndpoint: APIEndpointProtocol {
    var apiVersion: String {
        "v2/"
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
            "markets/tickers"
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
        case .getStockDetail(let id):
            return ["id": id, "type": "STOCKS"]
        }
    }
    
    var body: HTTPBody? {
        return nil
    }
}
