//
//  MyCartView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-19.
//

import SwiftUI

struct MyCartView: View {
    
    @StateObject var myCartViewModel = MyCartViewModel()
    
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
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Add address")
                            .font(.custom(mediumMark, size: 15))
                            .foregroundColor(.black)
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
            .padding(.top, 70)
            .padding(.leading, 42)
            .padding(.trailing, 35)
            
            Spacer()
                .frame(maxHeight: 50)
            
            HStack {
                Text("My Cart")
                    .font(.custom(boldMark, size: 35))
                    .padding(.leading, 42)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
                .frame(maxHeight: 49)
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 46) {
                        ForEach(myCartViewModel.basket, id: \.self) { basket in
                            productCell(basket: basket)
                        }
                    }
                }
                .padding(.top, 80)
                .padding(.horizontal, 23)
                
                Spacer()
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)))
                    .padding(.horizontal, 5)
                    .padding(.bottom, 15)
                
                totalCell(myCart: myCartViewModel.myCart)
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
                            .foregroundColor(Color.appOrange)
                        Text("Checkout")
                            .font(.custom(boldMark, size: 20))
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 44)
            }
            .background(Color.appBlue)
            .cornerRadius(30)
            
            
        }
        .ignoresSafeArea()
        .onAppear {
            myCartViewModel.fetchData()
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct MyCartView_Previews: PreviewProvider {
    static var previews: some View {
        MyCartView()
    }
}
