//
//  CapasityCapsule.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 24.07.2023.
//

import SwiftUI

struct CapasityCapsule: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    let product: Product
    
    var body: some View {
        ZStack {
            Capsule()
                .foregroundColor(Color.appOrange)
                .cornerRadius(10)
//            Text(capacity)
//                .font(.custom(boldMark, size: 13))
//                .foregroundColor(.black)
        }
        .frame(width: 71.43, height: 30.36)
    }
}

#Preview {
    CapasityCapsule(product: previewProduct)
}
