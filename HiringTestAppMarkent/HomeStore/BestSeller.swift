//
//  BestSeller.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-10.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
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
                            .background(Color(red: 1.079, green: 0.382, blue: 0.252))
                            .cornerRadius(50)
                        
                        Image(systemName: "heart")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                    }
                }
                .padding(.top, 11)
                .padding(.trailing, 15)
                
            }
            .frame(width: 181, height: 227, alignment: .top)
            .background(.orange)
            .cornerRadius(10)
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
