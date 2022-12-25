//
//  HotSalesView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-25.
//

import SwiftUI

// MARK: Hot sales tabView
extension HomeView {
    @ViewBuilder
    func hotSalesView(hotSalesData: HomeStore) -> some View {
        HStack {
            VStack(alignment: .leading) {
                
                if let _ = hotSalesData.isNew {
                    Text("New")
                        .font(.custom(regularMark, size: 10).bold())
                        .foregroundColor(Color.white)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(Color.appOrange)
                        )
                    
                }
                VStack(alignment: .leading) {
                    Text(hotSalesData.title)
                        .font(.custom(regularMark, size: 25).bold())
                        .foregroundColor(Color.white)
                    Text(hotSalesData.subtitle)
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
            AsyncImage(url: hotSalesData.picture)
                .frame(height: 182)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        )
        .padding()
    }
}

