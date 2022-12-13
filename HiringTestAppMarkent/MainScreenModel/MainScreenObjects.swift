//
//  asdf.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-10.
//

import Foundation

// MARK: - HomeStoreCard
struct MainScreenCardStruct: Codable {
    let homeStore: [HomeStore]
    let bestSeller: [BestSeller]
}

// MARK: - BestSeller
struct BestSeller: Codable {
    let id: UUID
    let isFavorites: Bool
    let title: String
    let priceWithoutDiscount, discountPrice: Int
    let picture: String
}

// MARK: - HomeStore
struct HomeStore: Codable {
    let id: Int
    let isNew: Bool
    let title, subtitle: String
    let picture: String
    let isBuy: Bool
}

