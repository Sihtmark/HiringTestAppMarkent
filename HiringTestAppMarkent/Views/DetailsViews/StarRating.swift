//
//  StarRating.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-27.
//

import SwiftUI

struct StarRating: View {
    
    struct ClipShape: Shape {
        
        let width: Double
        
        func path(in rect: CGRect) -> Path {
            Path(CGRect(x: rect.minX, y: rect.minY, width: width, height: rect.height))
        }
    }
    
    @Binding var rating: Double
    let maxRating: Int
    
    init(rating: Binding<Double>, maxRating: Int) {
        self.maxRating = maxRating
        self._rating = rating
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Text(Image(systemName: "star"))
                    .font(.system(size: 20))
                    .foregroundColor(.theme.yellow)
                    .aspectRatio(contentMode: .fill)
            }
        }.overlay(
            GeometryReader { reader in
                HStack(spacing: 0) {
                    ForEach(0..<maxRating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.theme.yellow)
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .clipShape(
                    ClipShape(width: (reader.size.width / CGFloat(maxRating)) * CGFloat(rating))
                )
            }
        )
    }
}
