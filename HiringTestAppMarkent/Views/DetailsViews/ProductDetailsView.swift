//
//  ProductDetailsView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-16.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm = HomeViewModel()
    
    var body: some View {
        VStack {
            HStack {
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
                //                NavigationLink {
                //                    HomeView()
                //                } label: {
                //                    ZStack {
                //                        Image(systemName: "chevron.left")
                //                            .foregroundColor(.white)
                //                            .font(.system(size: 14))
                //                    }
                //                    .frame(width: 37, height: 37)
                //                    .background(Color.appBlue)
                //                    .cornerRadius(10)
                //                }
                Spacer()
                Text("Product details")
                    .font(.custom(regularMark, size: 18))
                Spacer()
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
            .padding(.leading, 42)
            .padding(.trailing, 35)
            .padding(.vertical, 20)
            
            TabView {
                HStack(spacing: 30) {
                    ForEach(vm.singleProduct!.images, id: \.self) { urlString in
                        AsyncImage(url: URL(string: urlString)) { image in
                            image
                                .frame(width: 266)
                                .background(.orange)
                                .cornerRadius(20)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            .padding(.bottom, 15)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .shadow(color: Color.black.opacity(0.14), radius: 10)
            
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
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
    }
}

extension ProductDetailsView {
    @ViewBuilder
    func cellPicture(product: ProductModel) -> some View {
        ZStack {
            AsyncImage(url: URL(string: product.images[0])) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 266)
                    .background(.orange)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
            }
        }
    }
}
