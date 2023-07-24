//
//  CapacityPickerView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-27.
//

import SwiftUI

struct CapacityPickerView: View {
    
    var capacities: [String]
    
    @Binding var selectedCapacity: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.fixed(CGFloat(capacities.count)))]) {
                ForEach(capacities, id: \.self) { item in
                    Button{
                        selectedCapacity = item
                    } label: {
                        Text(item)
                            .foregroundColor( selectedCapacity == item ? .white : Color.init(hexString: "#8D8D8D"))
                    }
                    .fontWeight(Font.Weight.bold)
                    .frame(width: 70, height: 30, alignment: .center)
                    .background(selectedCapacity == item ? Color.init(hexString: "#FF6E4E") : .white)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
                }
            }
        }
//        .padding(.trailing, 30)
    }
}
