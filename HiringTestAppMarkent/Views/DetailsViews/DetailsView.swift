//
//  DetailsView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 24.07.2023.
//

import SwiftUI

struct DetailsView: View {
    
    @EnvironmentObject private var vm: ViewModel
    let type: ProductInfo
    
    var body: some View {
        HStack {
            VStack {
                Text(type.title)
                    .font(.custom(vm.productInfo == type ? FontTheme.instance.boldMark : FontTheme.instance.regularMark, size: 20))
                Capsule()
                    .frame(width: 86, height: 2)
                    .foregroundColor(vm.productInfo == type ? .accentColor : .white)
            }
        }
    }
}

struct DetailsView_Preview: PreviewProvider {
    static var previews: some View {
        DetailsView(type: ProductInfo.details)
            .environmentObject(ViewModel())
    }
}
