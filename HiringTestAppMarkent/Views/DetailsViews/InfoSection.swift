//
//  InfoSection.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 24.07.2023.
//

import SwiftUI

struct InfoSection: View {
    
    let product: Product
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleAndHeartSection
            
            StarRating(rating: .constant(product.rating), maxRating: 5)
                .padding(.horizontal, 38)
            
            Spacer()
            
            detailPickerSection
            
            Spacer()
            
            productInfoSection
            
            Spacer()
            
            addToCardButton
        }
    }
}

struct InfoSection_Previews: PreviewProvider {
    static var previews: some View {
        InfoSection(product: previewProduct)
            .environmentObject(HomeViewModel())
    }
}

extension InfoSection {
    
    var TitleAndHeartSection: some View {
        HStack {
            Text(product.title)
                .font(.custom(mediumMark, size: 24))
            Spacer()
            Button {
                
            } label: {
                ZStack {
                    Image("heart")
                        .foregroundColor(.white)
                        .frame(width: 14, height: 13)
                }
                .frame(width: 37, height: 37)
                .background(Color.appBlue)
                .cornerRadius(10)
            }
        }
        .padding(.horizontal, 38)
        .padding(.top, 28)
    }
    
    var detailPickerSection: some View {
        HStack(spacing: 23) {
            Spacer()
            ForEach(ProductInfo.allCases, id: \.self) { type in
                DetailsView(type: type)
                    .onTapGesture {
                        vm.switchProductInfo(type: type)
                    }
            }
            Spacer()
        }
    }
    
    var productInfoSection: some View {
        HStack {
            VStack {
                Image("stock")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 28)
                    .foregroundColor(.theme.iconSecondary)
                Text("Stock \(product.stock)")
                    .foregroundColor(.theme.iconSecondary)
                    .font(.custom(regularMark, size: 11))
            }
            Spacer()
            VStack {
                Image("label")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 28)
                    .foregroundColor(.theme.iconSecondary)
                Text("\(product.brand)")
                    .foregroundColor(.theme.iconSecondary)
                    .font(.custom(regularMark, size: 11))
            }
            Spacer()
            VStack {
                Image("discount")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 28)
                    .foregroundColor(.theme.iconSecondary)
                Text("\(Int(product.discountPercentage)) %")
                    .foregroundColor(.theme.iconSecondary)
                    .font(.custom(regularMark, size: 11))
            }
            Spacer()
            VStack {
                Image("savings")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 28)
                    .foregroundColor(.theme.iconSecondary)
                Text("Save \(Int(Double(product.price) * ((product.discountPercentage) / 100))) $")
                    .foregroundColor(.theme.iconSecondary)
                    .font(.custom(regularMark, size: 11))
            }
        }
        .padding(.leading, 30)
        .padding(.trailing, 40)
    }
    
    var addToCardButton: some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(Color.appOrange)
            HStack {
                Spacer()
                Text("Add to card")
                    .font(.custom(boldMark, size: 20))
                    .foregroundColor(.white)
                    .padding(.trailing, 20)
                Text("$\(Int(Double(product.price) * ((100.0 - product.discountPercentage) / 100.0)))")
                    .font(.custom(boldMark, size: 20))
                    .foregroundColor(.white)
                    .overlay(alignment: .bottomTrailing) {
                        Text("$\(product.price)")
                            .strikethrough()
                            .font(.custom(boldMark, size: 13))
                            .foregroundColor(.theme.iconSecondary)
                            .offset(x: 35, y: 6)
                    }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
    }
}
