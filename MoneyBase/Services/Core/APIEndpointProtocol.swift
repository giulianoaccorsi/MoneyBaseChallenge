//
//  APIEndpointProtocol.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 20/07/25.
//

import Foundation

protocol APIEndpointProtocol {
    var apiVersion: String { get }
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var urlParams: [String: any CustomStringConvertible] { get }
    var body: HTTPBody? { get }
}

extension APIEndpointProtocol {
    var url: URL? {
        var components = URLComponents(string: "\(baseURL)/\(apiVersion)\(path)")
        
        if !urlParams.isEmpty {
            components?.queryItems = urlParams.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
        }
        
        return components?.url
    }
    
    var defaultHeaders: [String: String] {
        var headers = [
            Constants.acceptHeader: Constants.applicationJSON
        ]
        
        if let body = body {
            headers[Constants.contentTypeHeader] = body.contentType
        }
        
        return headers
    }
    
    var allHeaders: [String: String] {
        return defaultHeaders.merging(headers) { _, new in new }
    }
}
