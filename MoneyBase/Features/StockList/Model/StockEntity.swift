//
//  StockEntity.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 18/07/25.
//

import Foundation

struct ResultResponse: Codable {
    let body: [StockEntity]
}

struct StockEntity: Codable, Identifiable {
    var id: UUID = UUID()
    let symbol, name, lastsale, netchange: String
    let pctchange, marketCap: String
    
    var isPorcentNegative: Bool {
        pctchange.hasPrefix("-")
    }
    
    enum CodingKeys: String, CodingKey {
        case symbol, name, lastsale, netchange, pctchange, marketCap
    }
}

extension StockEntity {
    static let preview: StockEntity =
        .init(
            symbol: "ABBV",
            name: "AbbVie Inc. Common Stock",
            lastsale: "$189.26",
            netchange: "-2.14",
            pctchange: "-1.118%",
            marketCap: "334,309,436,890"
        )
}

