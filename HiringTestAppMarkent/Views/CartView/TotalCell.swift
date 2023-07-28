//
//  TotalCell.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-25.
//

import SwiftUI

extension MyCartView {
    @ViewBuilder
    func totalCell(myCart: MyCart?) -> some View {
        if let myCart = myCart {
            HStack{
                VStack(alignment: .leading) {
                    Text("Total")
                        .font(.custom(FontTheme.instance.regularMark, size: 15))
                        .foregroundColor(.white)
                        .padding(.bottom, 12)
                    Text("Delivery")
                        .font(.custom(FontTheme.instance.regularMark, size: 15))
                        .foregroundColor(.white)
                        .padding(.bottom, 26)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("$\(myCart.total) us")
                        .font(.custom(FontTheme.instance.boldMark, size: 15))
                        .foregroundColor(.white)
                        .padding(.bottom, 12)
                    Text("\(myCart.delivery)")
                        .font(.custom(FontTheme.instance.boldMark, size: 15))
                        .foregroundColor(.white)
                        .padding(.bottom, 26)
                }
            }
        }
    }
}

