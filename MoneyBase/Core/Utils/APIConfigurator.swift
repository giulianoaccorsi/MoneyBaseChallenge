//
//  APIConfigurator.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 22/07/25.
//

import Foundation

enum APIConfigurator {
    static var apiKey: String {
        guard let key = Bundle.main.infoDictionary?["X_RAPID_API_KEY"] as? String else {
            fatalError("Yahoo Finance API Key not found in Config.xcconfig")
        }
        return key
    }
    
    static var apiHost: String {
        "yahoo-finance15.p.rapidapi.com"
    }
}
