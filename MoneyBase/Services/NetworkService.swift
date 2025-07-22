//
//  NetworkService.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 18/07/25.
//

import Foundation

protocol NetworkServiceProtocol: Sendable {
    func request<T: Codable>(
        _ endpoint: APIEndpointProtocol, responseType: T.Type
    ) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    private let session = URLSession.shared
    
    private init() {}
    
    func request<T: Codable>(
        _ endpoint: APIEndpointProtocol, responseType: T.Type
    ) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.allHeaders
        request.httpBody = endpoint.body?.data
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noResponse
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw NetworkError.serverError(httpResponse.statusCode)
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return decodedResponse
            } catch {
                throw NetworkError.decodingError(error)
            }
            
        } catch {
            if error is NetworkError {
                throw error
            } else {
                throw NetworkError.unknown
            }
        }
    }
}
