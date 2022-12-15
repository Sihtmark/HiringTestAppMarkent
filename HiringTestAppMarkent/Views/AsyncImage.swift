//
//  AsyncImage.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-15.
//

import SwiftUI

struct AsyncImage: View {
    
    @StateObject private var loader: MainScreenImageLoader
    
    init(url: String) {
        _loader = StateObject(wrappedValue: MainScreenImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.loadImage)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                Image(systemName: "heart")
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
//                    .scaleEffect(2)
            }
        }
    }
}
