//
//  StockDetailEntity.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 23/07/25.
//

import Foundation

struct StockDetailResult: Codable {
    let body: StockDetailEntity
}

struct StockDetailEntity: Codable {
    let longBusinessSummary: String?
    let industry: String?
    let sector: String?
    let address1: String?
    let city: String?
    let state: String?
    let country: String?
    let phone: String?
    let website: String?
    let fullTimeEmployees: Int?
    
    let companyOfficers: [CompanyOfficer]?
    
    let auditRisk: Int?
    let boardRisk: Int?
    let compensationRisk: Int?
    let overallRisk: Int?
    
    let governanceEpochDate: Int?
    let compensationAsOfEpochDate: Int?
    let irWebsite: String?
}

struct PayInfo: Codable {
    let raw: Int?
    let fmt: String?
    let longFmt: String?
}

struct CompanyOfficer: Codable {
    let name: String
    let title: String
    let age: Int?
    let totalPay: PayInfo?
    
    var initials: String {
        let components = name.components(separatedBy: " ")
        let firstInitial = components.first?.first.map(String.init) ?? ""
        let lastInitial = components.count > 1 ? components.last?.first.map(String.init) ?? "" : ""
        return firstInitial + lastInitial
    }
}
