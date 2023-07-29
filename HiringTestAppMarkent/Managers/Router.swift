//
//  Router.swift
//  HiringTestAppMarkent
//
//  Created by sihtmark on 29.07.2023.
//

import Foundation

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
