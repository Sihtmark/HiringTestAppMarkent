//
//  BestSeller.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-10.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Spacer()
                    .background(.green)
                    .frame(width: 187,height: 168)
                
                
                Button {
                    print("like")
                } label: {
                    ZStack {
                        Spacer()
                            .frame(width: 25, height: 25)
                            .background(.white)
                            .cornerRadius(50)
                        
                        Image(systemName: "heart")
                            .foregroundColor(Color(red: 1.079, green: 0.382, blue: 0.252))
                            .font(.system(size: 11))
                            .padding(.top, 1.5)
                    }
                }
                .padding(.top, 11)
                .padding(.trailing, 15)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    ZStack {
                        Text("$1,047")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.004, green: 0, blue: 0.208))
                            .kerning(-0.33)
                            .allowsTightening(true)
                            .frame(width: 50, height: 20)
                    }
                    .padding(.top, 7)
                    
                    Spacer()
                        .frame(width: 7)
                        
                    
                    ZStack {
                        Text("$1,500")
                            .font(.system(size: 13))
                            .strikethrough()
                            .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                            .kerning(-0.33)
                            .allowsTightening(true)
                    }
                    .padding(.top, 10)
                }
                
                Spacer()
                    .frame(height: 5)
                
                ZStack {
                    Text("Samsung Note 20 Ultra")
                        .font(.system(size: 10))
                        .foregroundColor(Color(red: 0.004, green: 0, blue: 0.208))
                        .kerning(-0.33)
                        .allowsTightening(true)
                }
            }
            .padding(.leading, 21)
        }
        .frame(width: 181, height: 227, alignment: .top)
        .background(.orange)
        .cornerRadius(10)
        
    }
        
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
