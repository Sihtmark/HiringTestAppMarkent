//
//  FiveCircles.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-11.
//

import Foundation

struct WhiteCircle: Identifiable  {
    let id = UUID()
    let name: String
    let image: String
}

let whiteCircles: [WhiteCircle] = [
    WhiteCircle(name: "Phones", image: "iphone"),
    WhiteCircle(name: "Computer", image: "laptopcomputer"),
    WhiteCircle(name: "Health", image: "bolt.heart"),
    WhiteCircle(name: "Books", image: "book.closed"),
    WhiteCircle(name: "Food", image: "takeoutbag.and.cup.and.straw")
]
