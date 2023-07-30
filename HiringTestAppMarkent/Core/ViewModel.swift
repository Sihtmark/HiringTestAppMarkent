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
    
    /// Gets all products
    ///
    /// Sends GET request to https://dummyjson.com/products and returns max 30 of 100 products back. Then adds all returned products to "bestSellers".
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
    
    /// Gets all products of one category
    ///
    /// Sends GET request to https://dummyjson.com/products/category/smartphones and returnes products of category that was declared in parameters. Then adds these products to "hotSales".
    ///
    /// - Parameter  category: category of products that will be retured
    ///
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
    
    /// Gets only one product
    ///
    /// Sends GET request to https://dummyjson.com/products/1 and returnes single product. Then adds this product to "singleProduct"
    ///
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
    
    /// Logins user and get token
    ///
    /// You can use any user's credentials from https://dummyjson.com/users
    ///
    /// Sends POST request to https://dummyjson.com/auth/login and if there is user with exact username and password returns that user back. Then adds this user to "user"
    ///
    /// - Parameter username: username of user that will be returned back
    /// - Parameter password: password of user that will be returned back
    ///
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
    
    /// Sends String and returns the array of products which title is contain that String
    ///
    /// Sends GET request to https://dummyjson.com/products/search?q=phone
    ///
    /// - Parameter product: text that will be used for searching products
    ///
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
    
    /// Gets array of all product categories
    ///
    /// Sends GET request to https://dummyjson.com/products/categories and returns array of all categories
    ///
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
    
    /// Adds new product and returns it back
    ///
    /// Sends POST request to https://dummyjson.com/products/add with parameters of product and returns new product back with new parameters
    ///
    /// - Warning: Adding a new product will not add it into the server
    ///
    /// It will simulate a POST request and will return the new created product with a new id
    ///
    func addProduct(id: Int, title: String, description: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: String, images: [String]
    ) async {
        do {
            let data = try await APIRequestDispatcher.request(
                apiRouter: .addProduct(id: id, title: title, description: description, price: price, discountPercentage: discountPercentage, rating: rating, stock: stock, brand: brand, category: category, thumbnail: thumbnail, images: images))
            let _ = try JSONDecoder().decode(Product.self, from: data)
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    /// Updates product with new title
    ///
    /// Sends PUT request to https://dummyjson.com/products/1 and returns product with new parameters that was updated
    ///
    /// - Warning: Updating a product will not update it into the server
    ///
    /// It will simulate a PUT/PATCH request and will return the product with modified data
    ///
    func updateProduct(title: String) async {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .updateProduct(title: title))
            let _ = try JSONDecoder().decode(Product.self, from: data)
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    /// Deletes product from the server
    ///
    /// Sends DELETE request to https://dummyjson.com/products/1
    ///
    /// - Warning: Deleting a product will not delete it into the server
    ///
    /// It will simulate a DELETE request and will return deleted product with "isDeleted" & "deletedOn" keys
    ///
    func deleteProduct() async {
        do {
            let data = try await APIRequestDispatcher.request(apiRouter: .deleteProduct)
            let _ = try JSONDecoder().decode(Product.self, from: data)
        } catch {
            print(URLError(.cannotDecodeRawData))
        }
    }
    
    /// Gets all products with auth token
    ///
    /// Sends GET request to https://dummyjson.com/auth/products with auth token and returns all products back if auth token is valid
    ///
    /// - Parameter token: given auth token that is used in authentication process, you can take it from User instance if it's not nil :)
    ///
    /// Then it returns all products but not more than 30 of 100 and adds all returned products to "bestSellers"
    ///
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
    
    /// Switches type of products that will be shown in HotSales section of the HomeView
    ///
    func switchProductType(type: ProductTypes) {
        withAnimation {
            productType = type
        }
    }
    
    /// Checks if array of favorites best sellers contains given best seller or not
    ///
    /// We need this function to mark best seller as favorite if array contain this best seller or not
    ///
    func favoritesBestSellersContains(_ bestSeller: Product) -> Bool {
        favoritesBestSellers.contains(bestSeller.id)
    }
    
    /// Adds new product to favorites best sellers
    ///
    /// Adds this product to best sellers when you press the button on the top right corner of best sellers sell
    ///
    func addBestSellerToFavorites(_ bestSeller: Product) {
        favoritesBestSellers.insert(bestSeller.id)
    }
    
    /// Removes product from favorites best sellers
    ///
    ///  Removes product from favorites when you press the button on the top right corner of best sellers sell
    func removeFromFavoritesBestSellers(_ bestSeller: Product) {
        favoritesBestSellers.remove(bestSeller.id)
    }
    
    /// Changes section in info section of ProductDetailsView
    ///
    func switchProductInfo(type: ProductInfo) {
        withAnimation {
            productInfo = type
        }
    }
}

