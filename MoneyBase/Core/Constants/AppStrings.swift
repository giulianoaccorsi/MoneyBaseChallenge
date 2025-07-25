//
//  LocalizationStrings+Extension.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 22/07/25.
//

import SwiftUI

struct AppStrings {
    struct UI {
        static var updatedLabel: String {
            String(localized: "updatedLabel")
        }
        
        static var marketInformation: String {
            String(localized: "marketInformation")
        }
        
        static var marketCap: String {
            String(localized: "marketCap")
        }
        
        static var employees: String {
            String(localized: "employees")
        }
        
        static var sector: String {
            String(localized: "sector")
        }
        
        static var industry: String {
            String(localized: "industry")
        }
        
        static var businessOverview: String {
            String(localized: "businessOverview")
        }
        
        static var keyStatistics: String {
            String(localized: "keyStatistics")
        }
        
        static var currentPrice: String {
            String(localized: "currentPrice")
        }
        
        static var netChange: String {
            String(localized: "netChange")
        }
        
        static var percentageChange: String {
            String(localized: "percentageChange")
        }
        
        static var companyInformation: String {
            String(localized: "companyInformation")
        }
        
        static var address: String {
            String(localized: "address")
        }
        
        static var country: String {
            String(localized: "country")
        }
        
        static var contactInformation: String {
            String(localized: "contactInformation")
        }
        
        static var phone: String {
            String(localized: "phone")
        }
        
        static var riskAssessment: String {
            String(localized: "riskAssessment")
        }
        
        static var auditRisk: String {
            String(localized: "auditRisk")
        }
        
        static var boardRisk: String {
            String(localized: "boardRisk")
        }
        
        static var compensationRisk: String {
            String(localized: "compensationRisk")
        }
        
        static var overallRisk: String {
            String(localized: "overallRisk")
        }
    }
    
    struct NetworkError {
        static var invalidURL: String {
            String(localized: "invalidURL")
        }
        
        static var noResponse: String {
            String(localized: "noResponse")
        }
        
        static var decodingError: String {
            String(localized: "decodingError")
        }
        
        static var serverError: String {
            String(localized: "serverError")
        }
        
        static var unknownError: String {
            String(localized: "unknownError")
        }
    }
    
    struct SystemImages {
        static let errorTriangle = "exclamationmark.triangle"
        static let chevronLeft = "chevron.left"
        static let chevronRight = "chevron.right"
        static let clockWise = "arrow.clockwise"
    }
}

extension LocalizedStringKey {
    static let navigationTitle = LocalizedStringKey("navigationTitle")
    static let loadingMessage = LocalizedStringKey("loadingMessage")
    static let updatedLabel = LocalizedStringKey("updatedLabel")
    static let tryAgainButton = LocalizedStringKey("tryAgainButton")
    static let errorTitle = LocalizedStringKey("errorTitle")
    static let searchPlaceholder = LocalizedStringKey("searchPlaceholder")
    
    static let detailTabOverview = LocalizedStringKey("detailTab.overview")
    static let detailTabCompany = LocalizedStringKey("detailTab.company")
    static let detailTabLeadership = LocalizedStringKey("detailTab.leadership")
    
    static let riskLevelLow = LocalizedStringKey("riskLevelLow")
    static let riskLevelMedium = LocalizedStringKey("riskLevelMedium")
    static let riskLevelHigh = LocalizedStringKey("riskLevelHigh")
}
