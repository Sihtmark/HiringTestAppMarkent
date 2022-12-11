//
//  SalesCategoryCell.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-11.
//

import SwiftUI

struct SalesCategoryCell: View {
    
    var whiteCircle: WhiteCircle
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 71)
                    .foregroundColor(.white)
                
                Image(systemName: whiteCircle.image)
                        .foregroundColor(Color(red: 0.702, green: 0.702, blue: 0.765))
                        .font(.system(size: 30))
            }
            
            Text(whiteCircle.name)
                .font(.system(size: 12))
                .foregroundColor(Color(red: 0.004, green: 0, blue: 0.208))
        }
        .onTapGesture {
            print("New Sales Category: ")
        }
    }
}

struct SalesCategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        SalesCategoryCell(whiteCircle: whiteCircles[0])
    }
}
