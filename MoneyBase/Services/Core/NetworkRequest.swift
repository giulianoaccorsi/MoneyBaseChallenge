//
//  NetworkRequest.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 18/07/25.
//

import Foundation

struct NetworkRequest {
    let url: String
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Data?
    let timeoutInterval: TimeInterval
    
    init(url: String,
         method: HTTPMethod = .GET,
         headers: [String: String]? = nil,
         body: Data? = nil,
         timeoutInterval: TimeInterval = 30.0) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.timeoutInterval = timeoutInterval
    }
}
