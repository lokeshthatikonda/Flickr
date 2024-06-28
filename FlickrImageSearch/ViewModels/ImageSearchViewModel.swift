//
//  ImageSearchViewModel.swift
//  FlickrImageSearch
//
//  Created by Lokesh Thatikonda on 06/28/24.
//

import Foundation
import Combine

class ImageSearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var images: [ImageData] = []
    @Published var isLoading = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.fetchImages(for: text)
            }
            .store(in: &cancellables)
    }

    private func fetchImages(for query: String) {
        guard !query.isEmpty else {
            images = []
            return
        }

        isLoading = true

        FlickrService.fetchImages(for: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    print("Error fetching images: \(error)")
                }
            }, receiveValue: { images in
                self.images = images
            })
            .store(in: &cancellables)
    }
}

