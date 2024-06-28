//
//  FlickrServiceTests.swift
//  FlickrImageSearchTests
//
//  Created by Lokesh Thatikonda on 06/28/24.
//

import XCTest
@testable import FlickrImageSearch
import Combine

class FlickrServiceTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testFetchImages() {
        let expectation = self.expectation(description: "Fetching images")

        FlickrService.fetchImages(for: "mountain")
            .sink(receiveCompletion: { _ in
                // Handle completion
            }, receiveValue: { images in
                XCTAssertFalse(images.isEmpty)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5)
    }
}
