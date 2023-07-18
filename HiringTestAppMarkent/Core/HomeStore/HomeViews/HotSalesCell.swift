//
//  HotSalesCell.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 18.07.2023.
//

import SwiftUI

struct HotSalesCell: View {
    
    let product: Product
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                if product.rating > 4.5  {
                    Text("New")
                        .font(.custom(regularMark, size: 10).bold())
                        .foregroundColor(Color.white)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(Color.accentColor)
                        )
                    
                }
                VStack(alignment: .leading) {
                    Text(product.title)
                        .font(.custom(regularMark, size: 25).bold())
                        .foregroundColor(Color.white)
                    Text(product.description)
                        .font(.custom(regularMark, size: 11))
                        .foregroundColor(Color.white)
                }
                Spacer()
                NavigationLink {
                    ProductDetailsView()
                } label: {
                    Text("Buy now!")
                        .font(.custom(regularMark, size: 11).bold())
                        .foregroundColor(.black)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 30)
                        .background(
                            RoundedRectangle(cornerRadius: 9)
                                .fill(Color.white)
                        )
                }
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.horizontal, 6)
        .background(
            AsyncImage(url: product.thumbnail)
                    .frame(height: 182)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
        )
        .padding()
    }
}

#Preview {
    HotSalesCell(product: previewProduct)
}
