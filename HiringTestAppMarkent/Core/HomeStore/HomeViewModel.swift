//
//  HomeViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-13.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var productType: ProductType = .smartphones
    @Published var productCarousel: Int = 0
    @Published var hotSales = [Product]()
    @Published var bestSellers = [Product]()
    @Published var image: UIImage = UIImage()
    @Published var isFavorite: Bool = false
    @Published var favoritesBestSellers = Set<Int>()
    
    func getAllProducts() async {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .getProducts)
            let responseObject = try JSONDecoder().decode(Products.self, from: data)
            await MainActor.run {
                self.bestSellers = responseObject.products
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
    
    func switchProductType(type: ProductType) {
        withAnimation {
            productType = type
        }
    }
    
    func favoritesBestSellersContains(_ bestSeller: Product) -> Bool {
        favoritesBestSellers.contains(bestSeller.id)
    }
    
    func addBestSellerToFavorites(_ bestSeller: Product) {
        favoritesBestSellers.insert(bestSeller.id)
    }
    
    func removeFromFavoritesBestSellers(_ bestSeller: Product) {
        favoritesBestSellers.remove(bestSeller.id)
    }
}

