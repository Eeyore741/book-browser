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
        let sut0 = BrowserDataModelLocal()
        let expectation = XCTestExpectation(description: "Wait for sut0.fetch completion")
        sut0.fetch(query: "any") { (result: BrowserDataResult) in
            guard case .success(_) = result else { return XCTFail("Sut0.fetch result error") }
            expectation.fulfill()
        }
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.1)
        XCTAssert(result == .completed, "Sut0.fetch result should be complete")
    }
    
    /// Test for data to be instantiated from helper static string
    func testDummyJSON() {
        XCTAssertNotNil(BrowserDataModelLocal.dummyJSON.data(using: String.Encoding.utf8), "Data instance should be returned")
    }
}
