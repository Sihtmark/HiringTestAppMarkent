//
//  ProductCell.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-25.
//

import SwiftUI

extension MyCartView {
    @ViewBuilder
    func productCell(basket: Basket?) -> some View {
        if let basket = basket {
            HStack {
                AsyncImage(url: basket.images)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 88, height: 88)
                    .clipped()
                    .cornerRadius(10)
                Spacer()
                VStack(alignment: .leading) {
                    Text(basket.title)
                        .foregroundColor(.white)
                        .font(.custom(mediumMark, size: 20))
                    Spacer()
                    Text("$\(basket.price)")
                        .foregroundColor(Color.appOrange)
                        .font(.custom(mediumMark, size: 20))
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: 160, alignment: .leading)
                Spacer()
                ZStack {
                    VStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "minus")
                                .foregroundColor(.white)
                                .font(.system(size: 10))
                        }
                        Spacer()
                        Text(String(myCartViewModel.quantity))
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 10))
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 5)
                    
                    
                }
                .frame(width: 26, height: 68)
                .background(Color.basketCard)
                .cornerRadius(26)
                Spacer()
                Button {
                    
                } label: {
                    Image("bin")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 14.75, height: 16)
                }
            }
            .frame(height: 88)
        }
        
    }
}

