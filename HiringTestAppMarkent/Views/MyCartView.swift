//
//  MyCartView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-19.
//

import SwiftUI

struct MyCartView: View {
    var body: some View {
        VStack {
            HStack {
                Button {
                    
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
            .padding(.leading, 42)
            .padding(.trailing, 35)
            
            Spacer()
            
            Text("My Cart")
                .font(.custom(boldMark, size: 35))
            
            Spacer()
            
            VStack {
                VStack {
                    Spacer()
                    productCell(basket: sampleBasket1)
                    Spacer()
                    productCell(basket: sampleBasket2)
                    Spacer()
                }
                .padding(.horizontal, 30)
            }
            .background(Color.appBlue)
            .cornerRadius(30)
        }
        
    }
}

struct MyCartView_Previews: PreviewProvider {
    static var previews: some View {
        MyCartView()
    }
}

extension MyCartView {
    @ViewBuilder
    func productCell(basket: Basket) -> some View {
        HStack {
            AsyncImage(url: basket.images)
                .aspectRatio(contentMode: .fill)
                .frame(width: 88, height: 88)
                .clipped()
                .cornerRadius(10)
            Spacer()
            VStack(alignment: .leading) {
                Text(basket.title)
                    .foregroundColor(.white)
                    .font(.custom(mediumMark, size: 20))
                Spacer()
                Text("$\(basket.price)")
                    .foregroundColor(Color.appOrange)
                    .font(.custom(mediumMark, size: 20))
                    .padding(.bottom, 10)
            }
            .frame(maxWidth: 160, alignment: .leading)
            Spacer()
            ZStack {
                VStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "minus")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                    }
                    Spacer()
                    Text("0")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                    }
                }
                .padding(.top, 12)
                .padding(.bottom, 5)
                
                
            }
            .frame(width: 26, height: 68)
            .background(Color.basketCard)
            .cornerRadius(26)
            Spacer()
            Button {
                
            } label: {
                Image("bin")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 14.75, height: 16)
            }
        }
        .frame(height: 88)
    }
}
