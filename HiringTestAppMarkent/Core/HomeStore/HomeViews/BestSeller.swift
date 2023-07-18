//
//  BestSeller.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-25.
//

import SwiftUI

// MARK: Best seller cardView
extension HomeView {
    @ViewBuilder
    func productCardView( bestSeller: BestSeller) -> some View {
        NavigationLink {
            ProductDetailsView()
        } label: {
            VStack(spacing: 0) {
                ZStack {
                    AsyncImage(url: bestSeller.picture)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height / 4, alignment: .center)
                        .clipped()
                    VStack {
                        HStack() {
                            Spacer()
                            ZStack {
                                Button {
                                    if favorites.contains(bestSeller) {
                                        favorites.remove(bestSeller)
                                    } else {
                                        favorites.add(bestSeller)
                                    }
                                } label: {
                                    Image(systemName: favorites.contains(bestSeller) ? "heart.fill" : "heart")
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
                
                HStack(alignment: .bottom) {
                    Text("$" + "\(bestSeller.priceWithoutDiscount)")
                        .font(Font.custom(boldMark, size: 16))
                        .foregroundColor(.black)
                    Text("$" + "\(bestSeller.discountPrice)")
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
}
