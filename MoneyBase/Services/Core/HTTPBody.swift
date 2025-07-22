//
//  HTTPBody.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 20/07/25.
//

import Foundation

enum HTTPBody {
    case data(Data)
    case json([String: Any])
    
    var contentType: String {
        switch self {
        case .data, .json:
            return Constants.applicationJSON
        }
    }
    
    var data: Data? {
        switch self {
        case .data(let data):
            return data
        case .json(let json):
            return try? JSONSerialization.data(withJSONObject: json)
        }
    }
}
