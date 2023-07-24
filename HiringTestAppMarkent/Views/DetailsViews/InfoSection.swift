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
            
            StarRating(rating: .constant(product.rating), maxRating: 5)
                .padding(.horizontal, 38)
            
            Spacer()
            
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
            Spacer()
            HStack {
                VStack {
                    Image("chip")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                    Text("\(product.rating)")
                        .foregroundColor(Color(UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)))
                        .font(.custom(regularMark, size: 11))
                    
                }
                Spacer()
                VStack {
                    Image("camera")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                    Text("\(product.category)")
                        .foregroundColor(Color(UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)))
                        .font(.custom(regularMark, size: 11))
                }
                Spacer()
                VStack {
                    Image("memory")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                    Text("\(product.id)")
                        .foregroundColor(Color(UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)))
                        .font(.custom(regularMark, size: 11))
                }
                Spacer()
                VStack {
                    Image("disk")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                    Text("\(product.discountPercentage)")
                        .foregroundColor(Color(UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)))
                        .font(.custom(regularMark, size: 11))
                }
            }
            .padding(.leading, 30)
            .padding(.trailing, 40)
            Spacer()
            
            
            Text("Select color and capacity")
                .font(.custom(mediumMark, size: 16))
                .padding(.leading, 30)
            
//            HStack {
//                ColorPickerView(colors: productViewModel.productModel!.color, selectedColor: $productViewModel.selectedColor)
//                
//                Spacer()
//                Spacer()
//                
//                CapacityPickerView(capacities: productViewModel.productModel!.capacity, selectedCapacity: $productViewModel.selectedCapacity)
//            }
//            .padding(.leading, 30)
//            .padding(.trailing, 40)
//                .padding(.bottom, 20)
            
            ZStack {
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(Color.appOrange)
                HStack {
                    Spacer()
                    Text("Add to card")
                        .font(.custom(boldMark, size: 20))
                        .foregroundColor(.white)
                    Spacer()
                    Text("$\(product.price)")
                        .font(.custom(boldMark, size: 20))
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
    }
}

#Preview {
    InfoSection(product: previewProduct)
}
