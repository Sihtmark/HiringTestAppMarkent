//
//  NetworkingManager.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 16.07.2023.
//

import SwiftUI

final class APIRequestDispatcher {
    
    class func request(apiRouter: APIRouter) async throws -> Data {
        
        var components = URLComponents()
        components.host = apiRouter.host
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
        
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
