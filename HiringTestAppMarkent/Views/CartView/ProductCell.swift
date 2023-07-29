//
//  ProductCell.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-25.
//

import SwiftUI

struct ProductCell: View {
    
    @EnvironmentObject private var vm: ViewModel
    let product: Product
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 88, height: 88)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            Spacer()
            VStack(alignment: .leading) {
                Text(product.title)
                    .foregroundColor(.white)
                    .font(.custom(FontTheme.instance.mediumMark, size: 20))
                Spacer()
                Text("$\(product.price)")
                    .foregroundColor(.accentColor)
                    .font(.custom(FontTheme.instance.mediumMark, size: 20))
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
                    Text(String("1"))
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
            .background(Color.theme.iconSecondary)
            .cornerRadius(26)
            Spacer()
            Button {
                
            } label: {
                Image.cartViewIcons.bin
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14.75, height: 16)
                    .foregroundColor(.theme.iconSecondary)
            }
        }
        .frame(height: 88)
    }
}

