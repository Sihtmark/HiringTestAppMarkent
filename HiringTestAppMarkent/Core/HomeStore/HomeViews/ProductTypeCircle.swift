//
//  ProductTypeCircle.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 18.07.2023.
//

import SwiftUI

struct ProductTypeCircle: View {
    
    let type: ProductType
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(vm.productType == type ? Color.accentColor : Color.white)
                    .frame(width: 71, height: 71)
                Image(type.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundColor(vm.productType == type ? Color.white : Color.black.opacity(0.3))
            }
            .shadow(color: .black.opacity(0.15), radius: 10)
            .padding(.horizontal)
            .padding(.top)
            
            Text(type.rawValue)
                .font(.custom(regularMark, size: 14))
                .foregroundColor(vm.productType == type ? Color.appOrange : Color.black)
        }
        .background(Color.white)
    }
}

struct ProductTypeCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProductTypeCircle(type: ProductType.smartphones)
            .environmentObject(HomeViewModel())
    }
}
