//
//  Products.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 17.07.2023.
//

import Foundation

struct Products: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}

