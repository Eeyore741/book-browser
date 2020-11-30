//
//  BrowserDataModelLocalTests.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 18/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import XCTest
@testable import book_browser

/// Type wrapping tests for `BrowserDataModelLocal` type
final class BrowserDataModelLocalTests: XCTestCase {
    
    /// Test for models fetch function expected to succeed
    func testFetchFine() {
        let expectation = self.expectation(description: "Wait for sut0.fetch completion")
        let sut0 = BrowserDataModelLocal()
        let delegate = DummyBrowserDataModelDelegate()
        sut0.delegate = delegate
        delegate.onDataModelStateChanged = { (model: BrowserDataModel) in
            if case let .inactive(attributes) = model.state {
                _ = try? XCTUnwrap(attributes, "Attributes should present")
                expectation.fulfill()
            }
        }
        sut0.fetch(query: "any")
        self.waitForExpectations(timeout: 0.1)
    }
    
    /// Test for data to be instantiated from helper static string
    func testDummyJSON() {
        XCTAssertNotNil(BrowserDataModelLocal.dummyJSON.data(using: String.Encoding.utf8), "Data instance should be returned")
    }
}
