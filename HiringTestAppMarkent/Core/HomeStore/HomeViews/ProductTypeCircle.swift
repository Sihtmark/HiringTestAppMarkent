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
                    .fill(vm.productType == type ? Color.appOrange : Color.white)
                    .frame(width: 71, height: 71)
                    .shadow(color: Color.shadow1, radius: 10)
                
                Image(type.imageName)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .foregroundColor(vm.productType == type ? Color.white : Color.black.opacity(0.3))
            }
            
            Text(type.title)
                .font(.custom(regularMark, size: 14))
                .foregroundColor(vm.productType == type ? Color.appOrange : Color.black)
        }
        .background(Color.white)
    }
}

struct ProductTypeCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProductTypeCircle(type: ProductType.books)
            .environmentObject(HomeViewModel())
    }
}
