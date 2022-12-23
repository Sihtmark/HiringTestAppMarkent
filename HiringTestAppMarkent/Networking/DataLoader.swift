//
//  DataLoader.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case serverError
    case decodingError
}

func getData1<T: Decodable>(url: String, completion: @escaping (Result<T,NetworkError>) -> Void) {
    
    guard let safeURL = URL(string: url) else {
        completion(.failure(NetworkError.invalidURL))
        return
    }
    
    URLSession.shared.dataTask(with: safeURL) { data, response, error in
        DispatchQueue.main.async {
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
    }.resume()
}



