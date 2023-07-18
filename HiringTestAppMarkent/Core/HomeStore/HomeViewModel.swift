//
//  HomeViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-13.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .phone
    @Published var productCarousel: Int = 0
    @Published var hotSales: [Product] = [Product]()
    @Published var bestSeller: [Product] = [Product]()
    @Published var favorites = FavoritesBestSellers()
    @Published var image: UIImage = UIImage()
    @Published var isFavorite: Bool = false
    
    func getProducts() async {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .getProducts)
            let responseObject = try JSONDecoder().decode(Products.self, from: data)
            await MainActor.run {
                self.bestSeller = responseObject.products
            }
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    func getProductsOfCategory(category: String) async {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .getProductsOfCategory(category: category))
            let responseObject = try JSONDecoder().decode(Products.self, from: data)
            await MainActor.run {
                self.hotSales = responseObject.products
            }
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    func switchProuductType(type: ProductType) {
        withAnimation {
            productType = type
        }
    }
}

class FavoritesBestSellers: ObservableObject {
    private var bestSellers: Set<Int>
    
    init() {
        bestSellers = []
    }
    
    func contains(_ bestSeller: Product) -> Bool {
        bestSellers.contains(bestSeller.id)
    }
    
    func add(_ bestSeller: Product) {
        objectWillChange.send()
        bestSellers.insert(bestSeller.id)
    }
    
    func remove(_ bestSeller: Product) {
        objectWillChange.send()
        bestSellers.remove(bestSeller.id)
    }
}
