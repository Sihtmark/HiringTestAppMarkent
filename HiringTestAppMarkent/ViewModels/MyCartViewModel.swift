//
//  MyCartViewModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-19.
//

import Foundation

class MyCartViewModel: ObservableObject {
    
    @Published var myCart: MyCart?
    
    func fetchData() {
        let url = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
        
        guard let safeUrl = URL(string: url) else { print("Invalid URL"); return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: safeUrl) { [weak self] data, response, error in
            
            if error != nil {
                print("Request error: \(error?.localizedDescription ?? "asdf")")
                return
            }
            
            if let safeData = data {
                if let myCart = self?.parseJSON(safeData) {
                    DispatchQueue.main.async {
                        self?.myCart = myCart
                    }
                }
            }
        }
        
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> MyCart? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(MyCart.self, from: data)
            
            //Get the last property from the decoded data.
            return decodedData
            
        } catch {
            
            print("Parsing JSON error: \(error)")
            return nil
        }
    }
    
    
}
