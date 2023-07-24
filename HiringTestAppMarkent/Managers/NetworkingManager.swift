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
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRouter.method
        
        switch apiRouter {
        case .getProducts, .getSingleProduct, .searchProducts, .getProductCategories, .getProductsOfCategory, .deleteProduct:
            break
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
