//
//  FavoritesBestSellers.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 21.07.2023.
//

import Foundation

class FavoritesBestSellers: ObservableObject {
    private var bestSellers: Set<Int>
    
    init() {
        bestSellers = []
    }
    
    func contains(_ bestSeller: Product) -> Bool {
        bestSellers.contains(bestSeller.id)
    }
    
    func add(_ bestSeller: Product) {
        objectWillChange.send()
        bestSellers.insert(bestSeller.id)
    }
    
    func remove(_ bestSeller: Product) {
        objectWillChange.send()
        bestSellers.remove(bestSeller.id)
    }
}
