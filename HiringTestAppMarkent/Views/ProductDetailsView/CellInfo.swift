//
//  CellInfo.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-25.
//

import SwiftUI

extension ProductDetailsView {
    @ViewBuilder
    func cellInfo(product: ProductModel?) -> some View {
        if let product = product {
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
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 18))
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 18))
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 18))
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 18))
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 18))
                }
                .padding(.horizontal, 38)
                Spacer()
                
                
                HStack(spacing: 23) {
                    Spacer()
                    ForEach(ProductInfo.allCases, id: \.self) { type in
                        detailsView(type: type)
                            .onTapGesture {
                                switchProductInfo(type: type)
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
                        Text(product.CPU)
                            .foregroundColor(Color(UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)))
                            .font(.custom(regularMark, size: 11))
                        
                    }
                    Spacer()
                    VStack {
                        Image("camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 28)
                        Text(product.camera)
                            .foregroundColor(Color(UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)))
                            .font(.custom(regularMark, size: 11))
                    }
                    Spacer()
                    VStack {
                        Image("memory")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 28)
                        Text(product.ssd)
                            .foregroundColor(Color(UIColor(red: 0.717, green: 0.717, blue: 0.717, alpha: 1)))
                            .font(.custom(regularMark, size: 11))
                    }
                    Spacer()
                    VStack {
                        Image("disk")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 28)
                        Text(product.sd)
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
                    .padding(.bottom, 15)
                
                HStack {
                    ForEach(product.color, id: \.self) { item in
                        colorCircle(color: item)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    ForEach(product.capacity, id: \.self) { item in
                        capacityCapsule(capacity: item)
                    }
                }
                .padding(.leading, 30)
                .padding(.trailing, 40)
                .padding(.bottom, 20)
                
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
}

