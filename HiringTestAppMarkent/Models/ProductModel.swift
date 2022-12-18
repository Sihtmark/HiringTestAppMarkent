//
//  ProductDetailsViewProductModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-17.
//

import Foundation

struct ProductModel: Codable, Hashable {
    let cpu, camera: String
    let capacity, color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd, ssd, title: String
}

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
