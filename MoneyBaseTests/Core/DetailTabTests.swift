//
//  DetailTabTests.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Testing
import SwiftUI
@testable import MoneyBase

@Suite("DetailTab Tests")
struct DetailTabTests {
    
    @Test("All cases are present")
    func testAllCases() {
        let allCases = DetailTab.allCases
        
        #expect(allCases.count == 3)
        #expect(allCases.contains(.overview))
        #expect(allCases.contains(.company))
        #expect(allCases.contains(.leadership))
    }
    
    @Test("Tab titles are localized string keys")
    func testTabTitles() {
        #expect(DetailTab.overview.title == .detailTabOverview)
        #expect(DetailTab.company.title == .detailTabCompany)
        #expect(DetailTab.leadership.title == .detailTabLeadership)
    }
    
    @Test("Each tab has unique title")
    func testUniqueTitles() {
        let titles = DetailTab.allCases.map { $0.title }
        let uniqueTitles = Set(titles.map { String(describing: $0) })
        
        #expect(titles.count == uniqueTitles.count)
    }
}
