//
//  HomeViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-13.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .tops
    @Published var productCarousel: Int = 0
    @Published var hotSales = [Product]()
    @Published var bestSeller = [Product]()
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
    
    func switchProductType(type: ProductType) {
        withAnimation {
            productType = type
        }
    }
}

