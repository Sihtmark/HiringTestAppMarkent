//
//  ImageLoader.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-13.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: String
    private var cancellable: AnyCancellable?

    init(url: String) {
        self.url = url
    }

    deinit {
        cancel()
    }
    
    func load() {
        guard let safeUrl = URL(string: url) else { return }
        cancellable = URLSession.shared.dataTaskPublisher(for: safeUrl)
                    .map { UIImage(data: $0.data) }
                    .replaceError(with: nil)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in self?.image = $0 }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
