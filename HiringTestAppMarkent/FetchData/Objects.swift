//
//  asdf.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-10.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let homeStore: [HomeStore]?
    let bestSeller: [BestSeller]?

    enum CodingKeys: String, CodingKey {
        case homeStore
        case bestSeller
    }
}

// MARK: - BestSeller
struct BestSeller: Codable {
    let id: UUID
    let isFavorites: Bool?
    let title: String?
    let priceWithoutDiscount, discountPrice: Int?
    let picture: String?

    enum CodingKeys: String, CodingKey {
        case id
        case isFavorites
        case title
        case priceWithoutDiscount
        case discountPrice
        case picture
    }
}

// MARK: - HomeStore
struct HomeStore: Codable {
    let id: Int?
    let isNew: Bool?
    let title, subtitle: String?
    let picture: String?
    let isBuy: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case isNew
        case title, subtitle, picture
        case isBuy
    }
}

