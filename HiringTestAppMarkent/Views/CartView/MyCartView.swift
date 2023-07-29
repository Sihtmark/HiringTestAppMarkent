//
//  MyCartView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-19.
//

import SwiftUI

struct MyCartView: View {
    
    @EnvironmentObject private var vm: ViewModel
    
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
                    .background(Color.theme.backgroundBlue)
                    .cornerRadius(10)
                }
                Spacer()
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Add address")
                            .font(.custom(FontTheme.instance.mediumMark, size: 15))
                            .foregroundColor(.black)
                        ZStack {
                            Image.cartViewIcons.cart
                                .foregroundColor(.white)
                                .frame(width: 14, height: 14)
                        }
                        .frame(width: 37, height: 37)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.top, 70)
            .padding(.leading, 42)
            .padding(.trailing, 35)
            
            Spacer()
                .frame(maxHeight: 50)
            
            HStack {
                Text("My Cart")
                    .font(.custom(FontTheme.instance.boldMark, size: 35))
                    .padding(.leading, 42)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
                .frame(maxHeight: 49)
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 45) {
                        ForEach(vm.hotSales, id: \.self) { product in
                            ProductCell(product: product)
                        }
                    }
                    .padding(.top, 30)
                }
                .padding(.horizontal, 23)
                
                Spacer()
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)))
                    .padding(.horizontal, 5)
                    .padding(.bottom, 15)
                
                TotalCell()
                    .padding(.horizontal, 55)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)))
                    .padding(.horizontal, 5)
                    .padding(.bottom, 27)
                
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 326, height: 54)
                            .cornerRadius(10)
                            .foregroundColor(.accentColor)
                        Text("Checkout")
                            .font(.custom(FontTheme.instance.boldMark, size: 20))
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 44)
            }
            .background(Color.theme.backgroundBlue)
            .cornerRadius(30)
            
            
        }
        .ignoresSafeArea()
        .task {
            await vm.getProductsOfCategory(category: ProductTypes.furniture.rawValue)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct MyCartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyCartView()
        }
        .environmentObject(ViewModel())
    }
}
