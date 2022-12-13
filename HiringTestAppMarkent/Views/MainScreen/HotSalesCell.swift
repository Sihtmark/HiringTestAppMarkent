//
//  HotSalesCell.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-09.
//

import SwiftUI

struct HotSalesCell: View {
    
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Spacer()
                .frame(width: 378, height: 182)
                .background(.black)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                
                Button("New") { print("Something New") }
                    .frame(width: 27, height: 27)
                    .background(Color(red: 1.079, green: 0.382, blue: 0.252))
                    .cornerRadius(50)
                    .font(.custom("New", size: 10))
                    .foregroundColor(.white)
                
                
                
                ZStack {
                    Text("Iphone 12")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .kerning(-0.33)
                        .multilineTextAlignment(.center)
                        .lineSpacing(30)
                        .allowsTightening(true)
                        .foregroundColor(.white)
                }
                .frame(width: 109, height: 30, alignment: .center)
                .padding(.top, 10.5)
                
                ZStack {
                    Text("Súper. Mega. Rápido.")
                        .font(.system(size: 11))
                        .frame(width: 91, height: 13, alignment: .center)
                        .lineLimit(1)
                        .kerning(-0.33)
                        .lineSpacing(13.13)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.87)
                        .foregroundColor(.white)
                }
                .frame(width: 91, height: 13, alignment: .center)
                .padding(.top, -3.5)
                
                Button("Buy now!") { print("Buy now!")}
                    .frame(width: 98, height: 23)
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(5)
                    .font(.system(size: 11))
                    .kerning(-0.33)
                    .fontWeight(.bold)
                    .padding(.top, 18)
            }
            .padding(.leading, 25.0)
            .padding(.top, 14)
        }
    }
}


struct HotSalesCell_Previews: PreviewProvider {
    static var previews: some View {
        HotSalesCell()
    }
}
