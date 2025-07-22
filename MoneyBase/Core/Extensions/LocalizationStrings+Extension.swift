//
//  LocalizationStrings+Extension.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 22/07/25.
//

import SwiftUI

// MARK: - AppStrings
struct AppStrings {
    struct UI {
        static var navigationTitle: String {
            String(localized: "navigationTitle")
        }
        
        static var loadingMessage: String {
            String(localized: "loadingMessage")
        }
        
        static var updatedLabel: String {
            String(localized: "updatedLabel")
        }
        
        static var tryAgainButton: String {
            String(localized: "tryAgainButton")
        }
        
        static var errorTitle: String {
            String(localized: "errorTitle")
        }
        
        static var searchPlaceholder: String {
            String(localized: "searchPlaceholder")
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
    
    // MARK: - System Images
    struct SystemImages {
        static let errorTriangle = "exclamationmark.triangle"
        static let chevronLeft = "chevron.left"
        static let chevronRight = "chevron.right"
    }
}

extension LocalizedStringKey {
    static let navigationTitle = LocalizedStringKey("navigationTitle")
    static let loadingMessage = LocalizedStringKey("loadingMessage")
    static let updatedLabel = LocalizedStringKey("updatedLabel")
    static let tryAgainButton = LocalizedStringKey("tryAgainButton")
    static let errorTitle = LocalizedStringKey("errorTitle")
    static let searchPlaceholder = LocalizedStringKey("searchPlaceholder")
}
