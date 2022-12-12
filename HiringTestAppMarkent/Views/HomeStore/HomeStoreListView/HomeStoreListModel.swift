//
//  HotSalesListModel.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-12.
//

import Foundation

final class HomeStoreListModel: ObservableObject {
    
    
    @Published var homeStoreCards: [HomeStoreCard] = []
    @Published var alertItem: AlertItem?
    
    func getHomeStoreCards() {
        
        NetworkManager.shared.getCards { [self] result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let homeStoreCards):
                    self.homeStoreCards = homeStoreCards
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}

