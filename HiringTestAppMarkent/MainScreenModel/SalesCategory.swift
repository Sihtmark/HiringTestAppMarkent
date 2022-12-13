//
//  FiveCircles.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-11.
//

import Foundation

enum SalesCategory: CaseIterable {
    case phone
    case computer
    case health
    case books
    case food
    
    var title: String {
        switch self {
        case .phone:
            return "Phones"
        case .computer:
            return "Computer"
        case .health:
            return "Health"
        case .books:
            return "Books"
        case .food:
            return "food"
        }
    }
    
    var imageName: String {
        switch self {
        case .phone:
            return "iphone"
        case .computer:
            return "laptopcomputer"
        case .health:
            return "bolt.heart"
        case .books:
            return "book.closed"
        case .food:
            return "takeoutbag.and.cup.and.straw"
        }
    }
}
