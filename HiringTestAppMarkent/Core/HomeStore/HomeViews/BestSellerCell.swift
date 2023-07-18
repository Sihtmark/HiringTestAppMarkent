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
        VStack(spacing: 0) {
            imageSection
            HStack(alignment: .bottom) {
                Text("$" + "\(bestSeller.price)")
                    .font(Font.custom(boldMark, size: 16))
                    .foregroundColor(.black)
                Text("$" + "\(Double(bestSeller.price) * (100.0 - bestSeller.discountPercentage))")
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
        .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height / 3)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: Color.shadow1, radius: 40)
        )
    }
}

struct BestSellerCell_Previews: PreviewProvider {
    static var previews: some View {
        BestSellerCell(bestSeller: previewProduct)
    }
}

extension BestSellerCell {
    var imageSection: some View {
        ZStack {
            AsyncImage(url: bestSeller.thumbnail)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height / 4, alignment: .center)
                .clipped()
            VStack {
                HStack() {
                    Spacer()
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
                                .frame(height: 11)
                                .foregroundColor(Color.appOrange)
                                .background(
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 25, height: 25)
                                        .shadow(color: Color.shadow2, radius: 20)
                                )
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding()
        }
    }
}
