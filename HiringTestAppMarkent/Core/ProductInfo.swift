//
//  ProductInfo.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 24.07.2023.
//

import Foundation

enum ProductInfo: CaseIterable {
    case shop
    case details
    case features
    
    var title: String {
        switch self {
        case .shop:
            return "Shop"
        case .details:
            return "Details"
        case .features:
            return "Features"
        }
    }
}
