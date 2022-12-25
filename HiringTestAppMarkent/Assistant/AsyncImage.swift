//
//  AsyncImage.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-15.
//

import SwiftUI

struct AsyncImage: View {
    
    @StateObject private var loader: ImageLoader

    init(url: String) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                Image(systemName: "heart")
            }
        }
    }
}

