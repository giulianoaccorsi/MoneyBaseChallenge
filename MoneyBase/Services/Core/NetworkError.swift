//
//  NetworkError.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 18/07/25.
//

import SwiftUI

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noResponse
    case decodingError(Error)
    case serverError(Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return AppStrings.NetworkError.invalidURL
        case .noResponse:
            return AppStrings.NetworkError.noResponse
        case .decodingError(let error):
            return String(format: AppStrings.NetworkError.decodingError, error.localizedDescription)
        case .serverError(let code):
            return String(format: AppStrings.NetworkError.serverError, code)
        case .unknown:
            return AppStrings.NetworkError.unknownError
        }
    }
}
