//
//  Icon.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 14.07.2023.
//

import SwiftUI

extension Image {
    static let homeIcons = HomeIcons()
    static let productViewIcons = ProductViewIcons()
    static let cartViewIcons = CartViewIcons()
}

struct HomeIcons {
    let arrow = Image("arrow")
    let books = Image("books")
    let camera = Image("camera")
    let cart = Image("cart")
    let chip = Image("chip")
    let computer = Image("computer")
    let disk = Image("disk")
    let ellipse = Image("ellipse")
    let filter = Image("filter")
    let heart = Image("heart")
    let memory = Image("memory")
    let metka = Image("metka")
    let phone = Image("phone")
    let profile = Image("profile")
    let qrCode = Image("qrCode")
}

struct ProductViewIcons {
    let discount = Image("discount")
    let label = Image("label")
    let savings = Image("savings")
    let stock = Image("stock")
    let cart = Image("cart")
    let heart = Image("heart")
}

struct CartViewIcons {
    let cart = Image("cart")
    let bin = Image("bin")
}
