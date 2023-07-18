//
//  MyCartModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-19.
//

import Foundation

// MARK: - MyCart
struct MyCart: Codable, Hashable {
    let basket: [Basket]
    let delivery, id: String
    let total: Int
}

// MARK: - Basket
struct Basket: Codable, Hashable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
