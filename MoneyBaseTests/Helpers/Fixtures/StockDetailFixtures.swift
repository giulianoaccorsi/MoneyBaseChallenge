//
//  StockDetailFixtures.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Foundation
@testable import MoneyBase

struct StockDetailFixtures {
    static let appleDetail = StockDetailEntity(
        longBusinessSummary: "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide.",
        industry: "Consumer Electronics",
        sector: "Technology",
        address1: "One Apple Park Way",
        city: "Cupertino",
        state: "CA",
        country: "United States",
        phone: "408-996-1010",
        website: "https://www.apple.com",
        fullTimeEmployees: 164000,
        companyOfficers: CompanyOfficerFixtures.appleOfficers,
        auditRisk: 2,
        boardRisk: 1,
        compensationRisk: 3,
        overallRisk: 2,
        governanceEpochDate: 1672531200,
        compensationAsOfEpochDate: 1672531200,
        irWebsite: "https://investor.apple.com"
    )
    
    static let teslaDetail = StockDetailEntity(
        longBusinessSummary: "Tesla, Inc. designs, develops, manufactures, leases, and sells electric vehicles, and energy generation and storage systems in the United States, China, and internationally.",
        industry: "Auto Manufacturers",
        sector: "Consumer Cyclical",
        address1: "1 Tesla Road",
        city: "Austin",
        state: "TX",
        country: "United States",
        phone: "512-516-8177",
        website: "https://www.tesla.com",
        fullTimeEmployees: 140473,
        companyOfficers: CompanyOfficerFixtures.teslaOfficers,
        auditRisk: 4,
        boardRisk: 3,
        compensationRisk: 5,
        overallRisk: 4,
        governanceEpochDate: 1672531200,
        compensationAsOfEpochDate: 1672531200,
        irWebsite: "https://ir.tesla.com"
    )
    
    static let microsoftDetail = StockDetailEntity(
        longBusinessSummary: "Microsoft Corporation develops, licenses, and supports software, services, devices, and solutions worldwide.",
        industry: "Software - Infrastructure",
        sector: "Technology",
        address1: "One Microsoft Way",
        city: "Redmond",
        state: "WA",
        country: "United States",
        phone: "425-882-8080",
        website: "https://www.microsoft.com",
        fullTimeEmployees: 221000,
        companyOfficers: CompanyOfficerFixtures.microsoftOfficers,
        auditRisk: 1,
        boardRisk: 1,
        compensationRisk: 2,
        overallRisk: 1,
        governanceEpochDate: 1672531200,
        compensationAsOfEpochDate: 1672531200,
        irWebsite: "https://www.microsoft.com/en-us/Investor"
    )
    
    static let minimalDetail = StockDetailEntity(
        longBusinessSummary: nil,
        industry: nil,
        sector: nil,
        address1: nil,
        city: nil,
        state: nil,
        country: nil,
        phone: nil,
        website: nil,
        fullTimeEmployees: nil,
        companyOfficers: nil,
        auditRisk: nil,
        boardRisk: nil,
        compensationRisk: nil,
        overallRisk: nil,
        governanceEpochDate: nil,
        compensationAsOfEpochDate: nil,
        irWebsite: nil
    )
    
    static let emptyOfficersDetail = StockDetailEntity(
        longBusinessSummary: "A company with no officers listed.",
        industry: "Technology",
        sector: "Software",
        address1: "123 Empty Street",
        city: "Nowhere",
        state: "CA",
        country: "United States",
        phone: "555-000-0000",
        website: "https://www.example.com",
        fullTimeEmployees: 1000,
        companyOfficers: [],
        auditRisk: 3,
        boardRisk: 3,
        compensationRisk: 3,
        overallRisk: 3,
        governanceEpochDate: 1672531200,
        compensationAsOfEpochDate: 1672531200,
        irWebsite: "https://investor.example.com"
    )
    
    static let highRiskDetail = StockDetailEntity(
        longBusinessSummary: "A high-risk company with maximum risk levels.",
        industry: "Cryptocurrency",
        sector: "Financial Services",
        address1: "456 Risk Avenue",
        city: "Volatile",
        state: "NV",
        country: "United States",
        phone: "555-RISK-123",
        website: "https://www.highrisk.com",
        fullTimeEmployees: 50,
        companyOfficers: CompanyOfficerFixtures.smallCompanyOfficers,
        auditRisk: 10,
        boardRisk: 10,
        compensationRisk: 10,
        overallRisk: 10,
        governanceEpochDate: 1672531200,
        compensationAsOfEpochDate: 1672531200,
        irWebsite: "https://investor.highrisk.com"
    )
}


struct CompanyOfficerFixtures {
    static let timCook = CompanyOfficer(
        name: "Tim Cook",
        title: "Chief Executive Officer",
        age: 62,
        totalPay: PayInfo(raw: 99000000, fmt: "$99M", longFmt: "$99,000,000")
    )
    
    static let lucaMaestri = CompanyOfficer(
        name: "Luca Maestri",
        title: "Chief Financial Officer",
        age: 59,
        totalPay: PayInfo(raw: 26000000, fmt: "$26M", longFmt: "$26,000,000")
    )
    
    static let jeffWilliams = CompanyOfficer(
        name: "Jeff Williams",
        title: "Chief Operating Officer",
        age: 59,
        totalPay: PayInfo(raw: 26000000, fmt: "$26M", longFmt: "$26,000,000")
    )
    
    static let appleOfficers = [timCook, lucaMaestri, jeffWilliams]
    
    static let elonMusk = CompanyOfficer(
        name: "Elon Musk",
        title: "Chief Executive Officer",
        age: 52,
        totalPay: PayInfo(raw: 0, fmt: "$0", longFmt: "$0")
    )
    
    static let zachKirkhorn = CompanyOfficer(
        name: "Zachary Kirkhorn",
        title: "Chief Financial Officer",
        age: 39,
        totalPay: PayInfo(raw: 46000000, fmt: "$46M", longFmt: "$46,000,000")
    )
    
    static let teslaOfficers = [elonMusk, zachKirkhorn]
    
    static let satyaNadella = CompanyOfficer(
        name: "Satya Nadella",
        title: "Chairman and Chief Executive Officer",
        age: 56,
        totalPay: PayInfo(raw: 44000000, fmt: "$44M", longFmt: "$44,000,000")
    )
    
    static let amyHood = CompanyOfficer(
        name: "Amy Hood",
        title: "Chief Financial Officer",
        age: 51,
        totalPay: PayInfo(raw: 27000000, fmt: "$27M", longFmt: "$27,000,000")
    )
    
    static let microsoftOfficers = [satyaNadella, amyHood]
    
    static let singleNameOfficer = CompanyOfficer(
        name: "Cher",
        title: "Chief Creative Officer",
        age: 77,
        totalPay: nil
    )
    
    static let noAgeOfficer = CompanyOfficer(
        name: "Jane Doe",
        title: "Chief Technology Officer",
        age: nil,
        totalPay: PayInfo(raw: 15000000, fmt: "$15M", longFmt: "$15,000,000")
    )
    
    static let noPay = CompanyOfficer(
        name: "John Smith",
        title: "Chief Marketing Officer",
        age: 45,
        totalPay: nil
    )
    
    static let emptyNameOfficer = CompanyOfficer(
        name: "",
        title: "Unknown Officer",
        age: nil,
        totalPay: nil
    )
    
    static let smallCompanyOfficers = [singleNameOfficer, noAgeOfficer]
    
    static func createOfficer(
        name: String,
        title: String,
        age: Int? = nil,
    ) -> CompanyOfficer {
        return CompanyOfficer(
            name: name,
            title: title,
            age: age,
            totalPay: nil
        )
    }
}
