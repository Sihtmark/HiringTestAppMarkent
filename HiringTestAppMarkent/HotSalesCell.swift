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
            Image("Group 5")
                .opacity(0.20)
            
            VStack {
                Button("New") { print("Something New") }
                    .frame(width: 27, height: 27)
                    .background(Color(red: 1.079, green: 0.382, blue: 0.252))
                    .cornerRadius(50)
                    .font(.custom("New", size: 10))
                    .foregroundColor(.white)
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
