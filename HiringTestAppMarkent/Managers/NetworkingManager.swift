//
//  NetworkingManager.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 16.07.2023.
//

import SwiftUI

enum APIRouter: Hashable {
    case getProducts
    case auth(username: String, password: String)
    case getSingleProduct
    case searchProducts(product: String)
    case getProductCategories
    case getProductsOfCategory(category: String)
    case addProduct(
        id: Int,
        title: String,
        description: String,
        price: Int,
        discountPercentage: Double,
        rating: Double,
        stock: Int,
        brand: String,
        category: String,
        thumbnail: String,
        images: [String]
    )
    case updateProduct(title: String)
    case deleteProduct
    case getProductsWithAuthToken(token: String)
    
    var host: String {
        switch self {
        case .getProducts,
                .auth,
                .getSingleProduct,
                .searchProducts,
                .getProductCategories,
                .getProductsOfCategory,
                .addProduct,
                .updateProduct,
                .deleteProduct,
                .getProductsWithAuthToken:
            return "dummyjson.com"
        }
    }
    
    var scheme: String {
        switch self {
        case .getProducts,
                .auth,
                .getSingleProduct,
                .searchProducts,
                .getProductCategories,
                .getProductsOfCategory,
                .addProduct,
                .updateProduct,
                .deleteProduct,
                .getProductsWithAuthToken:
            return "https"
        }
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .auth:
            return "/auth/login"
        case .getSingleProduct:
            return "/products/1"
        case .searchProducts(let product):
            return "/products/search?q=\(product)"
        case .getProductCategories:
            return "/products/categories"
        case .getProductsOfCategory(let category):
            return "/products/category/\(category)"
        case .addProduct:
            return "/products/add"
        case .updateProduct:
            return "/products/1"
        case .deleteProduct:
            return "/products/1"
        case .getProductsWithAuthToken:
            return "/auth/products"
        }
    }
    
    var method: String {
        switch self {
        case .getProducts,
                .getSingleProduct,
                .searchProducts,
                .getProductCategories,
                .getProductsOfCategory,
                .getProductsWithAuthToken:
            return "GET"
        case .addProduct, .updateProduct:
            return "PUT"
        case .auth:
            return "POST"
        case .deleteProduct:
            return "DELETE"
        }
    }
}

final class APIRequestDispatcher {
    
    class func request(apiRouter: APIRouter) async throws -> Data {
        
        var components = URLComponents()
        components.host = apiRouter.host
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
//        components.queryItems = apiRouter.parameters
        
        guard let url = components.url else { throw APIRequestError.badUrl }
        print(components.url!)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRouter.method
        
        switch apiRouter {
        case .getProducts, .getSingleProduct, .searchProducts, .getProductCategories, .getProductsOfCategory, .deleteProduct:
            print("We reached")
            
        case .auth(let username, let password):
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let json: [String: String] = ["username": username, "password": password]
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonData
        case .addProduct(let id, let title, let description, let price, let discountPercentage, let rating, let stock, let brand, let category, let thumbnail, let images):
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let json: [String: Any] = [
                "id": id,
                "title": title,
                "description": description,
                "price": price,
                "discountPercentage": discountPercentage,
                "rating": rating,
                "stock": stock,
                "brand": brand,
                "category": category,
                "thumbnail": thumbnail,
                "images": images
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonData
        case .updateProduct(let title):
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let json: [String: Any] = ["title": title]
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonData
        case .getProductsWithAuthToken(let token):
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        print("asdf")
        let session = URLSession(configuration: .default)
        
        return try await withCheckedThrowingContinuation { continuation in
            
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            dataTask.resume()
        }
    }
}

enum APIRequestError: Error {
    case badUrl, noData
}

//final class ProductsClient {
//    
//    static let shared = ProductsClient()
//    
//    func getProducts() async -> [Product] {
//        do {
//            let data = try await APIRequestDispatcher.request(apiRouter: .getProducts)
//            let responseObject = try JSONDecoder().decode(Products.self, from: data)
//            return responseObject.products
//        } catch {
//            
//        }
//    }
//}
//
//protocol SingleProductProtocol {
//    func getSingleProduct() async throws -> Product
//}
//
//final class SingleProductClient: SingleProductProtocol {
//    
//    static let shared = SingleProductClient()
//    
//    func getSingleProduct() async throws -> Product {
//        let response: Product = try await APIRequestDispatcher.request(apiRouter: .getSingleProduct)
//        return response
//    }
//}
//
//protocol UserProtocol {
//    func getUser(username: String, password: String) async throws -> User
//}
//
//final class UserClient: UserProtocol {
//    
//    static let shared = UserClient()
//    
//    func getUser(username: String, password: String) async throws -> User {
//        let response: User = try await APIRequestDispatcher.request(apiRouter: .auth(username: username, password: password))
//        return response
//    }
//}
//
//protocol SearchProductsProtocol {
//    func searchProducts(product: String) async throws -> [Product]
//}
//
//final class SearchProductsClient: SearchProductsProtocol {
//    
//    static let shared = SearchProductsClient()
//    
//    func searchProducts(product: String) async throws -> [Product] {
//        let response: Products = try await APIRequestDispatcher.request(apiRouter: .searchProducts(product: product))
//        return response.products
//    }
//}
//
//protocol GetProductCategoriesProtocol {
//    func getProductCategories() async throws -> [String]
//}
//
//final class GetProductCategoriesClient: GetProductCategoriesProtocol {
//    
//    static let shared = GetProductCategoriesClient()
//    
//    func getProductCategories() async throws -> [String] {
//        let response: [String] = try await APIRequestDispatcher.request(apiRouter: .getProductCategories)
//        return response
//    }
//}
//
//protocol GetProductsOfCategoryProtocol {
//    func getProductsOfCategory(category: String) async throws -> [Product]
//}
//
//final class GetProductsOfCategoryClient: GetProductsOfCategoryProtocol {
//    
//    static let shared = GetProductsOfCategoryClient()
//    
//    func getProductsOfCategory(category: String) async throws -> [Product] {
//        let response: Products = try await APIRequestDispatcher.request(apiRouter: .getProductsOfCategory(category: category))
//        return response.products
//    }
//}
//
//protocol AddProductProtocol {
//    func addProduct(id: Int, title: String, description: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: String, images: [String]
//    ) async throws -> Product
//}
//
//final class AddProductClient: AddProductProtocol {
//    
//    static let shared = AddProductClient()
//    
//    func addProduct(id: Int, title: String, description: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: String, images: [String]
//    ) async throws -> Product {
//        let response: Product = try await APIRequestDispatcher.request(
//            apiRouter: .addProduct(id: id, title: title, description: description, price: price, discountPercentage: discountPercentage, rating: rating, stock: stock, brand: brand, category: category, thumbnail: thumbnail, images: images))
//        return response
//    }
//}
//
//protocol UpdateProductProtocol {
//    func updateProduct(title: String) async throws -> Product
//}
//
//final class UpdateProductClient: UpdateProductProtocol {
//    
//    static let shared = UpdateProductClient()
//    
//    func updateProduct(title: String) async throws -> Product {
//        let response: Product = try await APIRequestDispatcher.request(apiRouter: .updateProduct(title: title))
//        return response
//    }
//}
//
//protocol DeleteProductProtocol {
//    func deleteProduct() async throws -> Product
//}
//
//final class DeleteProductClient: DeleteProductProtocol {
//    
//    static let shared = DeleteProductClient()
//    
//    func deleteProduct() async throws -> Product {
//        let response: Product = try await APIRequestDispatcher.request(apiRouter: .deleteProduct)
//        return response
//    }
//}
//
//protocol GetProductsWithAuthTokenProtocol {
//    func getProductsWithAuthToken(token: String) async throws -> [Product]
//}
//
//final class GetProductsWithAuthTokenClient: GetProductsWithAuthTokenProtocol {
//    
//    static let shared = GetProductsWithAuthTokenClient()
//    
//    func getProductsWithAuthToken(token: String) async throws -> [Product] {
//        let response: Products = try await APIRequestDispatcher.request(apiRouter: .getProductsWithAuthToken(token: token))
//        return response.products
//    }
//}

extension APIRouter {
//    var parameters: [URLQueryItem] {
//        switch self {
//        case .getProducts:
//            return []
//        case .auth:
//            return []
//        case .getSingleProduct:
//            return []
//        case .searchProducts(let product):
//            return []
//        case .getProductCategories:
//            return []
//        case .getProductsOfCategory(let category):
//            return []
//        case .addProduct:
//            return []
//        case .updateProduct:
//            return []
//        case .deleteProduct:
//            return []
//        case .getProductsWithAuthToken:
//            return []
//        }
//    }
}

extension APIRequestDispatcher {
    //func signIn() {
    //    let json: [String: String] = ["username": "kminchelle", "password": "0lelplR"]
    //    let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
    //    let url = URL(string: "https://dummyjson.com/auth/login")!
    //    var request = URLRequest(url: url)
    //    request.httpMethod = "POST"
    //    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //    request.httpBody = jsonData
    //    let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //        print("HTTPResponse: \(String(describing: response))")
    //        guard let data = data, error == nil else {
    //            print(error ?? "No data")
    //            return
    //        }
    //        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    //        if let responseJSON = responseJSON as? [String: Any] {
    //            print(responseJSON)
    //            // here I can
    //        } else {
    //
    //        }
    //    }
    //    task.resume()
    //}
}
