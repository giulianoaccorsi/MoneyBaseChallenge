//
//  MoneyBaseApp.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 18/07/25.
//

import SwiftUI

@main
struct MoneyBaseApp: App {
    var body: some Scene {
        WindowGroup {
            StockListView(
                viewModel: .init(
                    useCase: StockUseCase()
                )
            )
        }
    }
}
