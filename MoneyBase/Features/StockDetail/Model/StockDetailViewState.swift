//
//  StockDetailViewState.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 25/07/25.
//

import Foundation

enum StockDetailViewState {
    case loading
    case loaded(StockDetailEntity)
    case error(NetworkError)
}
