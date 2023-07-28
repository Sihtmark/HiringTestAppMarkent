//
//  CellPicture.swift
//  HiringTestAppMarkent
//
//  Created by sihtmark on 28.07.2023.
//

import SwiftUI

struct CellPicture: View {
    
    let product: Product
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: product.images[0])) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 266)
                    .background(.orange)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
            }
        }
    }
}
