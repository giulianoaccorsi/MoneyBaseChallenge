//
//  TestHelpers.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Testing
import Foundation
@testable import MoneyBase

struct TestHelpers {
    static func isLoading(_ state: StockDetailViewState) -> Bool {
        if case .loading = state { return true }
        return false
    }
    
    static func isLoaded(_ state: StockDetailViewState) -> Bool {
        if case .loaded = state { return true }
        return false
    }
    
    static func isError(_ state: StockDetailViewState) -> Bool {
        if case .error = state { return true }
        return false
    }
    
    static func getLoadedDetail(_ state: StockDetailViewState) -> StockDetailEntity? {
        if case .loaded(let detail) = state {
            return detail
        }
        return nil
    }
    
    static func getError(_ state: StockDetailViewState) -> NetworkError? {
        if case .error(let error) = state {
            return error
        }
        return nil
    }
    
    static func isLoading(_ state: StockListViewState) -> Bool {
        if case .loading = state { return true }
        return false
    }
    
    static func isLoaded(_ state: StockListViewState) -> Bool {
        if case .loaded = state { return true }
        return false
    }
    
    static func isError(_ state: StockListViewState) -> Bool {
        if case .error = state { return true }
        return false
    }
    
    static func getLoadedStocks(_ state: StockListViewState) -> [StockEntity]? {
        if case .loaded(let stocks) = state {
            return stocks
        }
        return nil
    }
    
    static func getError(_ state: StockListViewState) -> NetworkError? {
        if case .error(let error) = state {
            return error
        }
        return nil
    }
    
    static func isInvalidURL(_ error: NetworkError) -> Bool {
        if case .invalidURL = error { return true }
        return false
    }
    
    static func isNoResponse(_ error: NetworkError) -> Bool {
        if case .noResponse = error { return true }
        return false
    }
    
    static func isDecodingError(_ error: NetworkError) -> Bool {
        if case .decodingError = error { return true }
        return false
    }
    
    static func isServerError(_ error: NetworkError, code: Int) -> Bool {
        if case .serverError(let errorCode) = error {
            return errorCode == code
        }
        return false
    }
    
    static func isUnknownError(_ error: NetworkError) -> Bool {
        if case .unknown = error { return true }
        return false
    }
    
    static func wait(milliseconds: UInt64) async {
        try? await Task.sleep(nanoseconds: milliseconds * 1_000_000)
    }
}

extension TestHelpers {
    static func expectLoading(_ state: StockDetailViewState, file: StaticString = #file, line: UInt = #line) {
        if !isLoading(state) {
            Issue.record("Expected loading state")
        }
    }
    
    static func expectLoaded(_ state: StockDetailViewState, file: StaticString = #file, line: UInt = #line) -> StockDetailEntity? {
        guard let detail = getLoadedDetail(state) else {
            Issue.record("Expected loading state")
            return nil
        }
        return detail
    }
    
    static func expectError(_ state: StockDetailViewState, file: StaticString = #file, line: UInt = #line) -> NetworkError? {
        guard let error = getError(state) else {
            Issue.record("Expected error state")
            return nil
        }
        return error
    }
    
    static func expectLoading(_ state: StockListViewState, file: StaticString = #file, line: UInt = #line) {
        if !isLoading(state) {
            Issue.record("Expected loading state")
        }
    }
    
    static func expectLoaded(_ state: StockListViewState, file: StaticString = #file, line: UInt = #line) -> [StockEntity]? {
        guard let stocks = getLoadedStocks(state) else {
            Issue.record("Expected loaded state")
            return nil
        }
        return stocks
    }
    
    static func expectError(_ state: StockListViewState, file: StaticString = #file, line: UInt = #line) -> NetworkError? {
        guard let error = getError(state) else {
            Issue.record("Expected error state")
            return nil
        }
        return error
    }
}
