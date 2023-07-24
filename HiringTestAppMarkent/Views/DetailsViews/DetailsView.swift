//
//  DetailsView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 24.07.2023.
//

import SwiftUI

struct DetailsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    let type: ProductInfo
    
    var body: some View {
        HStack {
            VStack {
                Text(type.title)
                    .font(.custom(vm.productInfo == type ? boldMark : regularMark, size: 20))
                Capsule()
                    .frame(width: 86, height: 2)
                    .foregroundColor(vm.productInfo == type ? Color.appOrange : .white)
            }
        }
    }
}

#Preview {
    DetailsView(type: ProductInfo.details)
}
