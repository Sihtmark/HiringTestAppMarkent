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
            }
        }
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
    
    private func switchProductInfo(type: ProductInfo) {
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
