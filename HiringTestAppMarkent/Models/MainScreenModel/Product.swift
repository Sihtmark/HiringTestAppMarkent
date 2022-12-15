//
//  FiveCircles.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-11.
//

import Foundation

// MARK: - HomeStoreCard
struct MainScreenCardStruct: Codable {
    let home_store: [home_store]
    let best_seller: [best_seller]
    
//    enum CodingKeys: String, CodingKey {
//        case home_store = "home_store"
//        case bestSeller = "best_seller"
//    }
}

// MARK: - BestSeller
struct best_seller: Codable, Hashable {
    let id: Int
    let is_favorites: Bool
    let title: String
    let price_without_discount, discount_price: Int
    let picture: String
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case isFavorites = "is_favorites"
//        case title
//        case priceWithoutDiscount = "price_without_discount"
//        case discountPrice = "discount_price"
//        case picture
//    }
}

// MARK: - HomeStore
struct home_store: Codable, Hashable {
    let id: Int
    let is_new: Bool?
    let title, subtitle: String
    let picture: String
    let is_buy: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case isNew = "is_new"
//        case title, subtitle, picture
//        case isBuy = "is_buy"
//    }
}

enum SalesCategory: CaseIterable {
    case phone
    case computer
    case health
    case books
    case food
    
    var title: String {
        switch self {
        case .phone:
            return "Phones"
        case .computer:
            return "Computer"
        case .health:
            return "Health"
        case .books:
            return "Books"
        case .food:
            return "food"
        }
    }
    
    var imageName: String {
        switch self {
        case .phone:
            return "iphone"
        case .computer:
            return "laptopcomputer"
        case .health:
            return "bolt.heart"
        case .books:
            return "book.closed"
        case .food:
            return "takeoutbag.and.cup.and.straw"
        }
    }
}
