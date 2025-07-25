//
//  StockFixtures.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Foundation
@testable import MoneyBase

struct StockFixtures {
    static let appleStock = StockEntity(
        symbol: "AAPL",
        name: "Apple Inc.",
        lastsale: "$150.00",
        netchange: "2.50",
        pctchange: "1.69%",
        marketCap: "2,500,000,000,000"
    )
    
    static let teslaStock = StockEntity(
        symbol: "TSLA",
        name: "Tesla Inc.",
        lastsale: "$200.00",
        netchange: "-5.00",
        pctchange: "-2.44%",
        marketCap: "700,000,000,000"
    )
    
    static let microsoftStock = StockEntity(
        symbol: "MSFT",
        name: "Microsoft Corporation",
        lastsale: "$300.00",
        netchange: "10.00",
        pctchange: "3.45%",
        marketCap: "2,200,000,000,000"
    )
    
    static let googleStock = StockEntity(
        symbol: "GOOGL",
        name: "Alphabet Inc. Class A",
        lastsale: "$2500.00",
        netchange: "-25.00",
        pctchange: "-0.99%",
        marketCap: "1,600,000,000,000"
    )
    
    static let zeroChangeStock = StockEntity(
        symbol: "ZERO",
        name: "Zero Change Corp",
        lastsale: "$100.00",
        netchange: "0.00",
        pctchange: "0.00%",
        marketCap: "1,000,000,000"
    )
    
    static let smallNegativeStock = StockEntity(
        symbol: "SMALL",
        name: "Small Negative Corp",
        lastsale: "$50.00",
        netchange: "-0.01",
        pctchange: "-0.02%",
        marketCap: "500,000,000"
    )
    
    static let largePositiveStock = StockEntity(
        symbol: "LARGE",
        name: "Large Positive Corp",
        lastsale: "$1000.00",
        netchange: "100.00",
        pctchange: "11.11%",
        marketCap: "5,000,000,000,000"
    )
    
    static let basicStockList: [StockEntity] = [
        appleStock,
        teslaStock,
        microsoftStock
    ]
    
    static let mixedPerformanceStocks: [StockEntity] = [
        appleStock,
        teslaStock,
        zeroChangeStock,
        largePositiveStock
    ]
    
    static let searchTestStocks: [StockEntity] = [
        appleStock,
        teslaStock,
        microsoftStock,
        googleStock,
        teslaStock
    ]
    
    static func createStock(
        symbol: String,
        name: String,
        lastsale: String,
        netchange: String,
        pctchange: String,
        marketCap: String
    ) -> StockEntity {
        return StockEntity(
            symbol: symbol,
            name: name,
            lastsale: lastsale,
            netchange: netchange,
            pctchange: pctchange,
            marketCap: marketCap
        )
    }
}

extension StockEntity {
    static var testApple: StockEntity { StockFixtures.appleStock }
    static var testTesla: StockEntity { StockFixtures.teslaStock }
    static var testMicrosoft: StockEntity { StockFixtures.microsoftStock }
    static var testGoogle: StockEntity { StockFixtures.googleStock }
}
