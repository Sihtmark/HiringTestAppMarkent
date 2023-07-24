//
//  ColorPickerView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-27.
//

import SwiftUI

struct ColorPickerView: View {
    
    var colors: [String]
    
    @Binding var selectedColor: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.fixed(CGFloat(colors.count)))]) {
                ForEach(colors, id: \.self) { item in
                    Button {
                        selectedColor = item
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(selectedColor == item ? .white : Color.init(hexString: item))
                    }
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(Color.init(hexString: item))
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                }
            }
        }
    }
}
