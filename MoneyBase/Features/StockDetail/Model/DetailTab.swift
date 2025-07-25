//
//  DetailTab.swift
//  MoneyBase
//
//  Created by Giuliano Accorsi on 23/07/25.
//

import Foundation
import SwiftUI

enum DetailTab: CaseIterable {
    case overview
    case company
    case leadership
    
    var title: LocalizedStringKey {
        switch self {
        case .overview: return .detailTabOverview
        case .company: return .detailTabCompany
        case .leadership: return .detailTabLeadership
        }
    }
}
