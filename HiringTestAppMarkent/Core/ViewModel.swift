//
//  HomeViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-13.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    
    @Published var productType: ProductTypes = .smartphones
    @Published var hotSales = [Product]()
    @Published var bestSellers = [Product]()
    @Published var isFavorite: Bool = false
    @Published var favoritesBestSellers = Set<Int>()
    @Published var singleProduct: Product? = nil
    @Published var user: User? = nil
    @Published var productInfo: ProductInfo = .details
    
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
    
    func getSingleProduct() async {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .getSingleProduct)
            let responseObject = try JSONDecoder().decode(Product.self, from: data)
            await MainActor.run {
                self.singleProduct = responseObject
            }
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    func getUser(username: String, password: String) async {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .auth(username: username, password: password))
            let responseObject = try JSONDecoder().decode(User.self, from: data)
            await MainActor.run {
                self.user = responseObject
            }
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    func searchProducts(product: String) async -> [Product] {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .searchProducts(product: product))
            let responseObject = try JSONDecoder().decode(Products.self, from: data)
            return responseObject.products
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
        return []
    }
    
    func getProductCategories() async -> [String] {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .getProductCategories)
            let responseObject = try JSONDecoder().decode([String].self, from: data)
            return responseObject
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
        return []
    }
    
    func addProduct(id: Int, title: String, description: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: String, images: [String]
    ) async {
        do {
            let data = try await APIRequestDispatcher.request(
                apiRouter: .addProduct(id: id, title: title, description: description, price: price, discountPercentage: discountPercentage, rating: rating, stock: stock, brand: brand, category: category, thumbnail: thumbnail, images: images))
            let responseObject = try JSONDecoder().decode(Product.self, from: data)
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    func updateProduct(title: String) async {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .updateProduct(title: title))
            let responseObject = try JSONDecoder().decode(Product.self, from: data)
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    func deleteProduct() async {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .deleteProduct)
            let responseObject = try JSONDecoder().decode(Product.self, from: data)
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    func getProductsWithAuthToken(token: String) async throws {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .getProductsWithAuthToken(token: token))
            let responseObject = try JSONDecoder().decode(Products.self, from: data)
            await MainActor.run {
                self.bestSellers = responseObject.products
            }
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    func switchProductType(type: ProductTypes) {
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
    
    func switchProductInfo(type: ProductInfo) {
        withAnimation {
            productInfo = type
        }
    }
}

