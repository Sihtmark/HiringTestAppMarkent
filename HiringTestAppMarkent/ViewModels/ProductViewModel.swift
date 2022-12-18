//
//  ProductViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-17.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var productModel = [ProductModel]()
    @Published var productInfo: ProductInfo = .shop
    
    let sampleProductModel = ProductModel(
        cpu: "Exynos 990",
        camera: "108 + 12 mp",
        capacity: [
            "128",
            "256"
        ],
        color: [
            "#772D03",
            "#010035"
        ],
        id: "3",
        images: [
            "https://avatars.mds.yandex.net/get-mpic/5235334/img_id5575010630545284324.png/orig",
            "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg"
        ],
        isFavorites: true,
        price: 1500,
        rating: 4.5,
        sd: "256 GB",
        ssd: "8 GB",
        title: "Galaxy Note 20 Ultra"
    )
    
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
                        self?.productModel = [productModel]
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
            
            //Get the last property from the decoded data.
            return decodedData
            
        } catch {
            
            print("Parsing JSON error: \(error)")
            return nil
        }
    }
}
