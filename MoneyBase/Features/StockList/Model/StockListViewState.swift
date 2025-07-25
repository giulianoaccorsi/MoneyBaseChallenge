//
//  StockListViewState.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 20/07/25.
//

import Foundation

enum StockListViewState {
    case loading
    case loaded([StockEntity])
    case error(NetworkError)
}
