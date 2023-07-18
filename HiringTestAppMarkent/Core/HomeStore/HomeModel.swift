//
//  HomeModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-11.
//

import Foundation

// Product Model

// MARK: - HomeModel
struct HomeModel: Codable {
    let homeStore: [HomeStore]
    let bestSeller: [BestSeller]
}

// MARK: - BestSeller
struct BestSeller: Codable, Hashable, Identifiable {
    let id: Int
    var isFavorites: Bool
    let title: String
    let priceWithoutDiscount: Int
    let discountPrice: Int
    let picture: String
}

// MARK: - HomeStore
struct HomeStore: Codable, Hashable, Identifiable {
    let id: Int
    let isNew: Bool?
    let title: String
    let subtitle: String
    let picture: String
    let isBuy: Bool
}



// ProductTypes
enum ProductType: CaseIterable {
    case phone
    case computer
    case health
    case books
    case other
    
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
        case .other:
            return "Other"
        }
    }
    
    var imageName: String {
        switch self {
        case .phone:
            return "phone"
        case .computer:
            return "computer"
        case .health:
            return "health"
        case .books:
            return "books"
        case .other:
            return "other"
        }
    }
}

