//
//  HotSalesCell.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 18.07.2023.
//

import SwiftUI

struct HotSalesCell: View {
    
    let product: Product
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            productImage
            Rectangle()
                .fill(
                    LinearGradient(colors: [.black, .clear.opacity(0.0)], startPoint: .center, endPoint: .trailing)
                )
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(20)
        .overlay(alignment: .bottomLeading) {
            NavigationLink {
                ProductDetailsView()
            } label: {
                Text("Buy now!")
                    .font(.custom(boldMark, size: 11))
                    .foregroundColor(.black)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 30)
                    .background(
                        RoundedRectangle(cornerRadius: 9)
                            .fill(Color.white)
                    )
            }
            .offset(x: 20, y: -20)
        }
        .overlay(alignment: .topLeading) {
            VStack(alignment: .leading) {
                if product.rating > 4.5  {
                    Text("New")
                        .foregroundColor(Color.white)
                        .font(.custom(boldMark, size: 10))
                        .padding(8)
                        .background(
                            Circle()
                                .fill(Color.accentColor)
                        )
                }
                VStack(alignment: .leading) {
                    Text(product.title)
                        .font(.custom(boldMark, size: 18))
                        .foregroundColor(.accentColor)
                        .frame(maxWidth: 180, alignment: .leading)
                        .padding(.bottom, 6)
                    Text(product.description)
                        .font(.custom(regularMark, size: 8))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 180, alignment: .leading)
                }
            }
            .offset(x: 20, y: 20)
        }
    }
}

struct HotSalesCell_Previews: PreviewProvider {
    static var previews: some View {
        HotSalesCell(product: previewProduct)
            .environmentObject(HomeViewModel())
    }
}

extension HotSalesCell {
    
    var productImage: some View {
        AsyncImage(url: URL(string: product.images[0])) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(height: 200)
        } placeholder: {
            ProgressView()
        }
    }
}
