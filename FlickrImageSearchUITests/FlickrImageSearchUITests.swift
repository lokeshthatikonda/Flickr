//
//  FlickrImageSearchUITests.swift
//  FlickrImageSearchUITests
//
//  Created by Lokesh Thatikonda on 06/28/24.
//

import XCTest

final class FlickrImageSearchUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testSearchUI() {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.textFields["Search images..."]
        XCTAssertTrue(searchField.exists, "Search field should exist")
        
        searchField.tap()
        searchField.typeText("sunrise")
        
        // Tap 'return' button on the keyboard if needed
        app.keyboards.buttons["return"].tap()

        // Wait for the search results to load
        let firstImage = app.images.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == true")

        expectation(for: exists, evaluatedWith: firstImage, handler: nil)
        waitForExpectations(timeout: 10, handler: nil) // Increase the timeout if necessary

        XCTAssertTrue(firstImage.exists, "The first image should exist after a search")
    }
    
}
