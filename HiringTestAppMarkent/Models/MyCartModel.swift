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

let sampleCart = MyCart(
    basket: [sampleBasket1, sampleBasket2],
    delivery: "Free",
    id: "4",
    total: 3300
)

let sampleBasket1 = Basket(
    id: 1,
    images: "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg",
    price: 1500,
    title: "Galaxy Note 20 Ultra")

let sampleBasket2 = Basket(
    id: 2,
    images: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-pro-silver-select?wid=470&hei=556&fmt=jpeg&qlt=95&.v=1631652954000",
    price: 1800,
    title: "iPhone 13"
)
