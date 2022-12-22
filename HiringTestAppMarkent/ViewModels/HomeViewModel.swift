//
//  HomeViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-13.
//

import Foundation
import UIKit

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .phone
    @Published var productCarousel: Int = 0
    @Published var hotSales: [HomeStore] = [HomeStore]()
    @Published var bestSeller: [BestSeller] = [BestSeller]()
    @Published var image: UIImage = UIImage()
    
    func fetchData() {
        let url = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
        
        guard let safeUrl = URL(string: url) else { print("Invalid URL"); return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: safeUrl) { [weak self] data, response, error in
            
            if error != nil {
                print("Request error: \(error?.localizedDescription ?? "asdf")")
                return
            }
            
            if let safeData = data {
                if let homeModel = self?.parseJSON(safeData) {
                    DispatchQueue.main.async {
                        self?.hotSales = homeModel.homeStore
                        self?.bestSeller = homeModel.bestSeller
                    }
                }
            }
        }
        
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> HomeModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(HomeModel.self, from: data)
            return decodedData
        } catch {
            print("Parsing JSON error: \(error)")
            return nil
        }
    }
}
