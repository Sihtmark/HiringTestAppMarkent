//
//  TotalCell.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-25.
//

import SwiftUI

struct TotalCell: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("Total")
                    .font(.custom(FontTheme.instance.regularMark, size: 15))
                    .foregroundColor(.white)
                    .padding(.bottom, 12)
                Text("Delivery")
                    .font(.custom(FontTheme.instance.regularMark, size: 15))
                    .foregroundColor(.white)
                    .padding(.bottom, 26)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("$6,000 us")
                    .font(.custom(FontTheme.instance.boldMark, size: 15))
                    .foregroundColor(.white)
                    .padding(.bottom, 12)
                Text("Free")
                    .font(.custom(FontTheme.instance.boldMark, size: 15))
                    .foregroundColor(.white)
                    .padding(.bottom, 26)
            }
        }
    }
}
