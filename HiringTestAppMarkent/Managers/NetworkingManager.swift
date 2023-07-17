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
    
    class func request<T: Codable>(
        apiRouter: APIRouter,
        id: Int? = nil,
        title: String? = nil,
        description: String? = nil,
        price: Int? = nil,
        discountPercentage: Double? = nil,
        rating: Double? = nil,
        stock: Int? = nil,
        brand: String? = nil,
        category: String? = nil,
        thumbnail: String? = nil,
        images: [String]? = nil
    ) async throws -> T {
        
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
                
                if let error = error {
                    return continuation.resume(with: .failure(error))
                }
                
                guard let data = data else {
                    return continuation.resume(with: .failure(APIRequestError.noData))
                }
                
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        return continuation.resume(with: .success(responseObject))
                    }
                } catch {
                    return continuation.resume(with: .failure(error))
                }
            }
            dataTask.resume()
        }
    }
}

enum APIRequestError: Error {
    case badUrl, noData
}

protocol ProductsProtocol {
    func getProducts() async throws -> Products
}

final class ProductsClient: ProductsProtocol {
    func getProducts() async throws -> Products {
        let response: Products = try await APIRequestDispatcher.request(apiRouter: .getProducts)
        return response
    }
}

protocol SingleProductProtocol {
    func getSingleProduct() async throws -> Product
}

final class SingleProductClient: SingleProductProtocol {
    func getSingleProduct() async throws -> Product {
        let response: Product = try await APIRequestDispatcher.request(apiRouter: .getSingleProduct)
        return response
    }
}

protocol UserProtocol {
    func getUser(username: String, password: String) async throws -> User
}

final class UserClient: UserProtocol {
    func getUser(username: String, password: String) async throws -> User {
        let response: User = try await APIRequestDispatcher.request(apiRouter: .auth(username: username, password: password))
        return response
    }
}

protocol SearchProductsProtocol {
    func searchProducts(product: String) async throws -> Products
}

final class SearchProductsClient: SearchProductsProtocol {
    func searchProducts(product: String) async throws -> Products {
        let response: Products = try await APIRequestDispatcher.request(apiRouter: .searchProducts(product: product))
        return response
    }
}

protocol GetProductCategoriesProtocol {
    func getProductCategories() async throws -> [String]
}

final class GetProductCategoriesClient: GetProductCategoriesProtocol {
    func getProductCategories() async throws -> [String] {
        let response: [String] = try await APIRequestDispatcher.request(apiRouter: .getProductCategories)
        return response
    }
}

protocol GetProductsOfCategoryProtocol {
    func getProductsOfCategory(category: String) async throws -> Products
}

final class GetProductsOfCategoryClient: GetProductsOfCategoryProtocol {
    func getProductsOfCategory(category: String) async throws -> Products {
        let response: Products = try await APIRequestDispatcher.request(apiRouter: .getProductsOfCategory(category: category))
        return response
    }
}

protocol AddProductProtocol {
    func addProduct(id: Int, title: String, description: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: String, images: [String]
    ) async throws -> Product
}

final class AddProductClient: AddProductProtocol {
    func addProduct(id: Int, title: String, description: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: String, images: [String]
    ) async throws -> Product {
        let response: Product = try await APIRequestDispatcher.request(
            apiRouter: .addProduct(id: id, title: title, description: description, price: price, discountPercentage: discountPercentage, rating: rating, stock: stock, brand: brand, category: category, thumbnail: thumbnail, images: images))
        return response
    }
}

protocol UpdateProductProtocol {
    func updateProduct(title: String) async throws -> Product
}

final class UpdateProductClient: UpdateProductProtocol {
    func updateProduct(title: String) async throws -> Product {
        let response: Product = try await APIRequestDispatcher.request(apiRouter: .updateProduct(title: title))
        return response
    }
}

protocol DeleteProductProtocol {
    func deleteProduct() async throws -> Product
}

final class DeleteProductClient: DeleteProductProtocol {
    func deleteProduct() async throws -> Product {
        let response: Product = try await APIRequestDispatcher.request(apiRouter: .deleteProduct)
        return response
    }
}

protocol GetProductsWithAuthTokenProtocol {
    func getProductsWithAuthToken(token: String) async throws -> Products
}

final class GetProductsWithAuthTokenClient: GetProductsWithAuthTokenProtocol {
    func getProductsWithAuthToken(token: String) async throws -> Products {
        let response: Products = try await APIRequestDispatcher.request(apiRouter: .getProductsWithAuthToken(token: token))
        return response
    }
}

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
