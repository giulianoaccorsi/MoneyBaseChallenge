//
//  CompanyOfficerTests.swift
//  MoneyBaseTests
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Testing
import Foundation
@testable import MoneyBase

@Suite("CompanyOfficer Model Tests")
struct CompanyOfficerTests {
    @Test("Initials generation - two names")
    func testInitialsTwoNames() {
        let officer = CompanyOfficerFixtures.timCook
        
        #expect(officer.initials == "TC")
        #expect(officer.name == "Tim Cook")
        #expect(officer.title == "Chief Executive Officer")
    }
    
    @Test("Initials generation - single name")
    func testInitialsSingleName() {
        let officer = CompanyOfficerFixtures.singleNameOfficer
        
        #expect(officer.initials == "C")
        #expect(officer.name == "Cher")
    }
    
    @Test("Initials generation - three names")
    func testInitialsThreeNames() {
        let officer = CompanyOfficerFixtures.createOfficer(
            name: "John Michael Smith",
            title: "CTO",
            age: 45
        )
        
        #expect(officer.initials == "JS")
    }
    
    @Test("Initials generation - empty name")
    func testInitialsEmptyName() {
        let officer = CompanyOfficerFixtures.emptyNameOfficer
        
        #expect(officer.initials == "")
        #expect(officer.name == "")
    }
    
    @Test("Initials generation - special characters in name")
    func testInitialsSpecialCharacters() {
        let officer = CompanyOfficerFixtures.createOfficer(
            name: "Mary-Jane O'Connor",
            title: "CFO"
        )
        
        #expect(officer.initials == "MO")
    }
    
    @Test("Officer with age information")
    func testOfficerWithAge() {
        let officer = CompanyOfficerFixtures.timCook
        
        #expect(officer.age == 62)
        #expect(officer.totalPay != nil)
    }
    
    @Test("Officer without age information")
    func testOfficerWithoutAge() {
        let officer = CompanyOfficerFixtures.noAgeOfficer
        
        #expect(officer.age == nil)
        #expect(officer.name == "Jane Doe")
        #expect(officer.totalPay != nil)
    }
    
    @Test("Officer with pay information")
    func testOfficerWithPay() {
        let officer = CompanyOfficerFixtures.timCook
        
        #expect(officer.totalPay?.raw == 99000000)
        #expect(officer.totalPay?.fmt == "$99M")
        #expect(officer.totalPay?.longFmt == "$99,000,000")
    }
    
    @Test("Officer without pay information")
    func testOfficerWithoutPay() {
        let officer = CompanyOfficerFixtures.noPay
        
        #expect(officer.totalPay == nil)
        #expect(officer.name == "John Smith")
        #expect(officer.age == 45)
    }
    
    @Test("Officer with zero pay")
    func testOfficerWithZeroPay() {
        let officer = CompanyOfficerFixtures.elonMusk
        
        #expect(officer.totalPay?.raw == 0)
        #expect(officer.totalPay?.fmt == "$0")
        #expect(officer.totalPay?.longFmt == "$0")
    }
    
    @Test("Factory method creates officer correctly")
    func testFactoryMethodCreation() {
        let officer = CompanyOfficerFixtures.createOfficer(
            name: "Test Officer",
            title: "Test Title",
            age: 40
        )
        
        #expect(officer.name == "Test Officer")
        #expect(officer.title == "Test Title")
        #expect(officer.age == 40)
        #expect(officer.initials == "TO")
    }
}

@Suite("CompanyOfficer JSON Decoding Tests")
struct CompanyOfficerJSONTests {
    
    @Test("Decodes complete officer from JSON")
    func testCompleteOfficerDecoding() throws {
        let json = """
        {
            "name": "Tim Cook",
            "title": "Chief Executive Officer",
            "age": 62,
            "totalPay": {
                "raw": 99000000,
                "fmt": "$99M",
                "longFmt": "$99,000,000"
            }
        }
        """
        
        let data = json.data(using: .utf8)!
        let officer = try JSONDecoder().decode(CompanyOfficer.self, from: data)
        
        #expect(officer.name == "Tim Cook")
        #expect(officer.title == "Chief Executive Officer")
        #expect(officer.age == 62)
        #expect(officer.totalPay?.raw == 99000000)
        #expect(officer.initials == "TC")
    }
    
    @Test("Decodes minimal officer from JSON")
    func testMinimalOfficerDecoding() throws {
        let json = """
        {
            "name": "Jane Doe",
            "title": "CFO"
        }
        """
        
        let data = json.data(using: .utf8)!
        let officer = try JSONDecoder().decode(CompanyOfficer.self, from: data)
        
        #expect(officer.name == "Jane Doe")
        #expect(officer.title == "CFO")
        #expect(officer.age == nil)
        #expect(officer.totalPay == nil)
        #expect(officer.initials == "JD")
    }
    
    @Test("Decodes officer with null values from JSON")
    func testOfficerWithNullValuesDecoding() throws {
        let json = """
        {
            "name": "John Smith",
            "title": "CTO",
            "age": null,
            "totalPay": null
        }
        """
        
        let data = json.data(using: .utf8)!
        let officer = try JSONDecoder().decode(CompanyOfficer.self, from: data)
        
        #expect(officer.name == "John Smith")
        #expect(officer.title == "CTO")
        #expect(officer.age == nil)
        #expect(officer.totalPay == nil)
    }
}
