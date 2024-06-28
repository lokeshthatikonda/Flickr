//
//  FlickrImageSearchTests.swift
//  FlickrImageSearchTests
//
//  Created by Lokesh Thatikonda on 06/28/24.
//

import XCTest
import Combine
@testable import FlickrImageSearch

class ImageSearchViewModelTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []

    func testSearchUpdatesImages() {
        let viewModel = ImageSearchViewModel()

        let expectation = self.expectation(description: "Fetching images")
        
        viewModel.$images
            .dropFirst() // Skip the initial value
            .sink { images in
                XCTAssertFalse(images.isEmpty, "Images should not be empty after search")
                expectation.fulfill()
            }
            .store(in: &cancellables) // Store the AnyCancellable

        viewModel.searchText = "sunrise"

        waitForExpectations(timeout: 5)
    }
    
    func testSearchWithNoResults() {
        let viewModel = ImageSearchViewModel()
        let expectation = self.expectation(description: "Fetching images with no results")

        viewModel.$images
            .dropFirst()
            .sink { images in
                XCTAssertTrue(images.isEmpty, "Images should be empty for a query with no results")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchText = "nonsensequerythatisnotlikelytoyieldresults"

        waitForExpectations(timeout: 5)
    }

    override func tearDown() {
        cancellables.removeAll() // Clean up cancellables after each test
        super.tearDown()
    }
}
