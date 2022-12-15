//
//  MainScreenViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-13.
//

import Foundation
import UIKit

class MainScreenViewModel: ObservableObject {
    @Published var salesCategory: SalesCategory = .phone
    @Published var hotSales = [home_store]()
    @Published var bestSellers = [best_seller]()
    
    @Published var image = UIImage()
    
    func fetchData() {
        let url = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
        guard let safeUrl = URL(string: url) else {
            print("Wrong URL")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: safeUrl) { [weak self] data, response, error in
            if error != nil {
                print("Network error: \(error?.localizedDescription ?? "asdf")")
                return
            }
            if let data = data {
                if let mainScreenModel = self?.parse(data) {
                    DispatchQueue.main.async {
                        self?.hotSales = mainScreenModel.home_store
                        self?.bestSellers = mainScreenModel.best_seller
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parse(_ data: Data) -> MainScreenCardStruct? {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let data = try decoder.decode(MainScreenCardStruct.self, from: data)
            return data
        } catch {
            print("Parsing error: \(error)")
            return nil
        }
    }
}

