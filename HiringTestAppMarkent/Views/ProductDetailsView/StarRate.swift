//
//  StarRate.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-27.
//

import SwiftUI

extension ProductDetailsView {
    @ViewBuilder
    func starRate(rate: Double) -> some View {
        HStack {
            ForEach(1..<Int(rate) + 1, id: \.self) { number in
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding(.horizontal, 38)
    }
}
