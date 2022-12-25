//
//  ProductTypeView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-25.
//

import SwiftUI

// MARK: Product typeView
extension HomeView {
    @ViewBuilder
    func productTypeView(type: ProductType) -> some View {
        VStack {
            ZStack {
                Circle()
                    .fill(homeViewModel.productType == type ? Color.appOrange : Color.white)
                    .frame(width: 71, height: 71)
                    .shadow(color: Color.shadow1, radius: 10)
                
                Image(type.imageName)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .foregroundColor(homeViewModel.productType == type ? Color.white : Color.black.opacity(0.3))
            }
            
            Text(type.title)
                .font(.custom(regularMark, size: 14))
                .foregroundColor(homeViewModel.productType == type ? Color.appOrange : Color.black)
        }
        .background(Color.white)
    }
    
    func switchProuductType(type: ProductType) {
        withAnimation {
            homeViewModel.productType = type
        }
    }
}
