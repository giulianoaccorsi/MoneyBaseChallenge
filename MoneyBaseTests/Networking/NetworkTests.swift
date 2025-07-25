//
//  NetworkTests.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Testing
import SwiftUI
@testable import MoneyBase

@Suite("NetworkError Tests")
struct NetworkErrorTests {
    @Test("Invalid URL error description")
    func testInvalidURLErrorDescription() {
        let error = NetworkError.invalidURL
        
        #expect(error.errorDescription != nil)
        #expect(error.errorDescription?.isEmpty == false)
    }
    
    @Test("No response error description")
    func testNoResponseErrorDescription() {
        let error = NetworkError.noResponse
        
        #expect(error.errorDescription != nil)
        #expect(error.errorDescription?.isEmpty == false)
    }
    
    @Test("Server error description with code")
    func testServerErrorDescription() {
        let error = NetworkError.serverError(404)
        
        #expect(error.errorDescription != nil)
        #expect(error.errorDescription?.contains("404") == true)
    }
    
    @Test("Decoding error description")
    func testDecodingErrorDescription() {
        let underlyingError = NSError(domain: "TestDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        let error = NetworkError.decodingError(underlyingError)
        
        #expect(error.errorDescription != nil)
        #expect(error.errorDescription?.isEmpty == false)
    }
    
    @Test("Unknown error description")
    func testUnknownErrorDescription() {
        let error = NetworkError.unknown
        
        #expect(error.errorDescription != nil)
        #expect(error.errorDescription?.isEmpty == false)
    }
    
    @Test("All error types can be tested with helpers")
    func testErrorHelpers() {
        #expect(TestHelpers.isInvalidURL(.invalidURL))
        #expect(TestHelpers.isNoResponse(.noResponse))
        #expect(TestHelpers.isDecodingError(.decodingError(NSError(domain: "test", code: 1))))
        #expect(TestHelpers.isServerError(.serverError(500), code: 500))
        #expect(TestHelpers.isUnknownError(.unknown))
        
        #expect(!TestHelpers.isInvalidURL(.noResponse))
        #expect(!TestHelpers.isServerError(.serverError(404), code: 500))
    }
}

@Suite("HTTP Method Tests")
struct HTTPMethodTests {
    
    @Test("HTTP methods have correct raw values")
    func testHTTPMethodRawValues() {
        #expect(HTTPMethod.GET.rawValue == "GET")
        #expect(HTTPMethod.POST.rawValue == "POST")
        #expect(HTTPMethod.PUT.rawValue == "PUT")
        #expect(HTTPMethod.DELETE.rawValue == "DELETE")
        #expect(HTTPMethod.PATCH.rawValue == "PATCH")
    }
}
