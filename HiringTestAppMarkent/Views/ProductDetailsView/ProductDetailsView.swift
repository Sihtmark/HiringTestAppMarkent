//
//  ProductDetailsView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-16.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @StateObject var productViewModel = ProductViewModel()
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    HomeView()
                } label: {
                    ZStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    .frame(width: 37, height: 37)
                    .background(Color.appBlue)
                    .cornerRadius(10)
                }
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
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(productViewModel.images, id: \.self) { item in
                        AsyncImage(url: item)
                            .frame(width: 266)
                            .background(.orange)
                            .cornerRadius(20)
                            .shadow(color: Color.shadow, radius: 10)
                    }
                }
            }
            .padding(.bottom, 15)
            cellInfo(product: productViewModel.productModel)
                .cornerRadius(15)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                        .shadow(color: Color.shadow1, radius: 20, y: -5)
                )
        }
        .background(Color.appBackground)
        .onAppear {
            productViewModel.fetchData()
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
            AsyncImage(url: product.images[0])
                .aspectRatio(contentMode: .fit)
        }
        .frame(width: 266)
        .background(.orange)
        .cornerRadius(20)
    }
}


extension ProductDetailsView {
    @ViewBuilder
    func detailsView(type: ProductInfo) -> some View {
        HStack {
            VStack {
                Text(type.title)
                    .font(.custom(boldMark, size: 20))
                Capsule()
                    .frame(width: 86, height: 2)
                    .foregroundColor(productViewModel.productInfo == type ? Color.appOrange : .white)
            }
            
        }
    }
    
    func switchProductInfo(type: ProductInfo) {
        withAnimation {
            productViewModel.productInfo = type
        }
    }
}

extension ProductDetailsView {
    @ViewBuilder
    func colorCircle(color: String) -> some View {
        ZStack {
            Circle()
                .frame(width: 40)
                .foregroundColor(Color.init(hexString: color))
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .font(.system(size: 13).bold())
                .opacity(1.0)
        }
    }
    
}

extension ProductDetailsView {
    @ViewBuilder
    func capacityCapsule(capacity: String) -> some View {
        ZStack {
            Capsule()
                .foregroundColor(Color.appOrange)
                .cornerRadius(10)
            Text(capacity)
                .font(.custom(boldMark, size: 13))
                .foregroundColor(.black)
        }
        .frame(width: 71.43, height: 30.36)
    }
    
}
