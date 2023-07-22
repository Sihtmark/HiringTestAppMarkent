//
//  BestSellerCell.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 18.07.2023.
//

import SwiftUI

struct BestSellerCell: View {
    
    @StateObject private var vm = HomeViewModel()
    
    let bestSeller: Product
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: bestSeller.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height * 0.265)
                
            ZStack {
                Color.white
                VStack {
                    HStack(alignment: .bottom) {
                        Text("$" + "\(Int(Double(bestSeller.price) * (100.0 - bestSeller.discountPercentage) / 100))")
                            .font(Font.custom(regularMark, size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("$" + "\(bestSeller.price)")
                            .font(.custom(mediumMark, size: 10))
                            .foregroundColor(Color.black.opacity(0.3))
                            .strikethrough(true, color: Color.black.opacity(0.3))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 6.5)
                    
                    HStack {
                        Text(bestSeller.title)
                            .font(.custom(regularMark, size: 10))
                            .foregroundColor(.black)
                        Spacer()
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom)
                }
            }
            .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height * 0.075)
        }
        
        .cornerRadius(15)
        .background(
            Color.white
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .overlay(alignment: .topTrailing) {
            ZStack {
                Button {
                    if vm.favorites.contains(bestSeller) {
                        vm.favorites.remove(bestSeller)
                    } else {
                        vm.favorites.add(bestSeller)
                    }
                } label: {
                    Image(systemName: vm.favorites.contains(bestSeller) ? "heart.fill" : "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 11, height: 10)
                        .foregroundColor(.accentColor)
                        .background(
                            Circle()
                                .fill(.white)
                                .frame(width: 25, height: 25)
                                .shadow(color: .black.opacity(0.15), radius: 10)
                        )
                }
                .offset(x: -15, y: 15)
            }
        }
    }
}

struct BestSellerCell_Previews: PreviewProvider {
    static var previews: some View {
        BestSellerCell(bestSeller: previewProduct)
    }
}
