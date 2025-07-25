//
//  StockEntityTests.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Testing
import Foundation
@testable import MoneyBase

@Suite("StockEntity Model Tests")
struct StockEntityTests {
    @Test("Percentage negative detection - positive change")
    func testPositivePercentageChange() {
        let stock = StockFixtures.appleStock
        
        #expect(!stock.isPorcentNegative)
        #expect(stock.pctchange == "1.69%")
    }
    
    @Test("Percentage negative detection - negative change")
    func testNegativePercentageChange() {
        let stock = StockFixtures.teslaStock
        
        #expect(stock.isPorcentNegative)
        #expect(stock.pctchange == "-2.44%")
    }
    
    @Test("Percentage negative detection - zero change")
    func testZeroPercentageChange() {
        let stock = StockFixtures.zeroChangeStock
        
        #expect(!stock.isPorcentNegative)
        #expect(stock.pctchange == "0.00%")
    }
    
    @Test("Percentage negative detection - small negative")
    func testSmallNegativePercentageChange() {
        let stock = StockFixtures.smallNegativeStock
        
        #expect(stock.isPorcentNegative)
        #expect(stock.pctchange == "-0.02%")
    }
    
    @Test("Percentage negative detection - large positive")
    func testLargePositivePercentageChange() {
        let stock = StockFixtures.largePositiveStock
        
        #expect(!stock.isPorcentNegative)
        #expect(stock.pctchange == "11.11%")
    }
    
    @Test("Net change value formatting - positive")
    func testNetChangeValueFormattingPositive() {
        let stock = StockFixtures.appleStock
        
        #expect(stock.netChangeValue == "$ 2.50")
    }
    
    @Test("Net change value formatting - negative")
    func testNetChangeValueFormattingNegative() {
        let stock = StockFixtures.teslaStock
        
        #expect(stock.netChangeValue == "$ -5.00")
    }
    
    @Test("Net change value formatting - zero")
    func testNetChangeValueFormattingZero() {
        let stock = StockFixtures.zeroChangeStock
        
        #expect(stock.netChangeValue == "$ 0.00")
    }
    
    @Test("Net change value formatting - small values")
    func testNetChangeValueFormattingSmall() {
        let stock = StockFixtures.smallNegativeStock
        
        #expect(stock.netChangeValue == "$ -0.01")
    }
    
    @Test("Net change value formatting - large values")
    func testNetChangeValueFormattingLarge() {
        let stock = StockFixtures.largePositiveStock
        
        #expect(stock.netChangeValue == "$ 100.00")
    }
    
    @Test("Stock entity properties are correctly set")
    func testStockEntityProperties() {
        let stock = StockFixtures.microsoftStock
        
        #expect(stock.symbol == "MSFT")
        #expect(stock.name == "Microsoft Corporation")
        #expect(stock.lastsale == "$300.00")
        #expect(stock.netchange == "10.00")
        #expect(stock.pctchange == "3.45%")
        #expect(stock.marketCap == "2,200,000,000,000")
    }
    
    @Test("Unique ID generation")
    func testUniqueIDGeneration() {
        let stock1 = StockEntity(
            symbol: "TEST",
            name: "Test Corp",
            lastsale: "$100.00",
            netchange: "1.00",
            pctchange: "1.00%",
            marketCap: "1,000,000,000"
        )
        
        let stock2 = StockEntity(
            symbol: "TEST",
            name: "Test Corp",
            lastsale: "$100.00",
            netchange: "1.00",
            pctchange: "1.00%",
            marketCap: "1,000,000,000"
        )
        
        #expect(stock1.id != stock2.id)
    }
    
    @Test("Preview stock entity is valid")
    func testPreviewStockEntity() {
        let preview = StockEntity.preview
        
        #expect(!preview.symbol.isEmpty)
        #expect(!preview.name.isEmpty)
        #expect(!preview.lastsale.isEmpty)
        #expect(!preview.netchange.isEmpty)
        #expect(!preview.pctchange.isEmpty)
        #expect(!preview.marketCap.isEmpty)
        #expect(preview.symbol == "ABBV")
        #expect(preview.isPorcentNegative)
    }
    
    @Test("Convenience extensions work correctly")
    func testConvenienceExtensions() {
        let apple = StockEntity.testApple
        let tesla = StockEntity.testTesla
        let microsoft = StockEntity.testMicrosoft
        let google = StockEntity.testGoogle
        
        #expect(apple.symbol == "AAPL")
        #expect(tesla.symbol == "TSLA")
        #expect(microsoft.symbol == "MSFT")
        #expect(google.symbol == "GOOGL")
    }
}

@Suite("StockEntity JSON Decoding Tests")
struct StockEntityJSONTests {
    
    @Test("Decodes from valid JSON")
    func testValidJSONDecoding() throws {
        let json = """
        {
            "symbol": "AAPL",
            "name": "Apple Inc.",
            "lastsale": "$150.00",
            "netchange": "2.50",
            "pctchange": "1.69%",
            "marketCap": "2,500,000,000,000"
        }
        """
        
        let data = json.data(using: .utf8)!
        let stock = try JSONDecoder().decode(StockEntity.self, from: data)
        
        #expect(stock.symbol == "AAPL")
        #expect(stock.name == "Apple Inc.")
        #expect(stock.lastsale == "$150.00")
        #expect(stock.netchange == "2.50")
        #expect(stock.pctchange == "1.69%")
        #expect(stock.marketCap == "2,500,000,000,000")
    }
    
    @Test("Decodes with special characters in strings")
    func testSpecialCharactersDecoding() throws {
        let json = """
        {
            "symbol": "TEST@123",
            "name": "Test & Company Inc. 中文",
            "lastsale": "$75.00",
            "netchange": "1.50",
            "pctchange": "2.04%",
            "marketCap": "750,000,000"
        }
        """
        
        let data = json.data(using: .utf8)!
        let stock = try JSONDecoder().decode(StockEntity.self, from: data)
        
        #expect(stock.symbol == "TEST@123")
        #expect(stock.name == "Test & Company Inc. 中文")
    }
    
    @Test("Decodes negative values correctly")
    func testNegativeValuesDecoding() throws {
        let json = """
        {
            "symbol": "TSLA",
            "name": "Tesla Inc.",
            "lastsale": "$200.00",
            "netchange": "-5.00",
            "pctchange": "-2.44%",
            "marketCap": "700,000,000,000"
        }
        """
        
        let data = json.data(using: .utf8)!
        let stock = try JSONDecoder().decode(StockEntity.self, from: data)
        
        #expect(stock.netchange == "-5.00")
        #expect(stock.pctchange == "-2.44%")
        #expect(stock.isPorcentNegative)
    }
}

@Suite("ResultResponse Tests")
struct ResultResponseTests {
    
    @Test("Decodes array of stocks correctly")
    func testResultResponseDecoding() throws {
        let json = """
        {
            "body": [
                {
                    "symbol": "AAPL",
                    "name": "Apple Inc.",
                    "lastsale": "$150.00",
                    "netchange": "2.50",
                    "pctchange": "1.69%",
                    "marketCap": "2,500,000,000,000"
                },
                {
                    "symbol": "TSLA",
                    "name": "Tesla Inc.",
                    "lastsale": "$200.00",
                    "netchange": "-5.00",
                    "pctchange": "-2.44%",
                    "marketCap": "700,000,000,000"
                }
            ]
        }
        """
        
        let data = json.data(using: .utf8)!
        let response = try JSONDecoder().decode(ResultResponse.self, from: data)
        
        #expect(response.body.count == 2)
        #expect(response.body.first?.symbol == "AAPL")
        #expect(response.body.last?.symbol == "TSLA")
    }
    
    @Test("Decodes empty array correctly")
    func testEmptyResultResponseDecoding() throws {
        let json = """
        {
            "body": []
        }
        """
        
        let data = json.data(using: .utf8)!
        let response = try JSONDecoder().decode(ResultResponse.self, from: data)
        
        #expect(response.body.isEmpty)
    }
} 
