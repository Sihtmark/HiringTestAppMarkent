//
//  ProductViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-17.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var productModel: ProductModel?
    @Published var productInfo: ProductInfo = .shop
    @Published var images = [String]()
//    @Published var colors = [String]()
//    @Published var capacities = [String]()
    @Published var selectedColor = ""
    @Published var selectedCapacity = ""
    
    func fetchData() {
        let url = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
        
        guard let safeUrl = URL(string: url) else { print("Invalid URL"); return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: safeUrl) { [weak self] data, response, error in
            
            if error != nil {
                print("Request error: \(error?.localizedDescription ?? "asdf")")
                return
            }
            
            if let safeData = data {
                if let productModel = self?.parseJSON(safeData) {
                    DispatchQueue.main.async {
                        self?.productModel = productModel
                        self?.images = productModel.images
                        self?.selectedColor = productModel.color[0]
                        self?.selectedCapacity = productModel.capacity[0]
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> ProductModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(ProductModel.self, from: data)
            return decodedData
        } catch {
            print("Parsing JSON error: \(error)")
            return nil
        }
    }
}
