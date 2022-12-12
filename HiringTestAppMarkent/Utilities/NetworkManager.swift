//
//  NetworkManager.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-12.
//

import UIKit

class NetworkManager {
    
    static let shared            = NetworkManager()
    private let cache            = NSCache<NSString, UIImage>()
    private let baseURL          = "https://run.mocky.io/v3/"
    fileprivate let homeStoreURL  = "v3/654bd15e-b121-49ba-a588-960956b15175"
    
    func getCards(completed: @escaping (Result<[HomeStoreCard], APError>) -> Void) {
        guard let url = URL(string: baseURL + homeStoreURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(WelcomeResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
