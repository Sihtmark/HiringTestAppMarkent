//
//  ProductDetailsView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-16.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        VStack {
            tabView
            
            if let product = vm.singleProduct {
                InfoSection(product: product)
                    .cornerRadius(15)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                            .shadow(color: Color.shadow1, radius: 20, y: -5)
                    )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.appBackground)
        .task {
            await vm.getSingleProduct()
        }
        .navigationBarTitle("Product details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    ZStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    .frame(width: 37, height: 37)
                    .background(Color.appBlue)
                    .cornerRadius(10)
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    MyCartView()
                } label: {
                    ZStack {
                        Image("cart")
                            .foregroundColor(.white)
                            .frame(width: 14, height: 14)
                    }
                    .frame(width: 37, height: 37)
                    .background(Color.appOrange)
                    .cornerRadius(10)
                }
            }
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductDetailsView()
        }
        .environmentObject(HomeViewModel())
    }
}

extension ProductDetailsView {
    var tabView: some View {
        TabView {
            if let product = vm.singleProduct {
                ForEach(product.images, id: \.self) { urlString in
                    AsyncImage(url: URL(string: urlString)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .background(.orange)
                            .cornerRadius(15)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
        .padding(.vertical)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .shadow(color: Color.black.opacity(0.14), radius: 10)
    }
}
