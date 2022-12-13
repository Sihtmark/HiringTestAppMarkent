//
//  MainScreenViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-13.
//

import Foundation

class MainScreenViewModel: ObservableObject {
    @Published var salesCategory: SalesCategory = .phone
    @Published var hotSales = [HomeStore]()
    @Published var bestSellers = [BestSeller]()
    
    func getMainScreenCards() {
        let url = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
        guard let safeUrl = URL(string: url) else {
            print("Wrong URL")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: safeUrl) { [weak self] data, response, error in
            if error != nil {
                print("Network error")
                return
            }
            if let data = data {
                if let mainScreenModel = self?.parse(data) {
                    DispatchQueue.main.async {
                        self?.hotSales = mainScreenModel.homeStore
                        self?.bestSellers = mainScreenModel.bestSeller
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parse(_ data: Data) -> MainScreenCardStruct? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let data = try decoder.decode(MainScreenCardStruct.self, from: data)
            return data
        } catch {
            print("Parsing error")
            return nil
        }
    }
}

