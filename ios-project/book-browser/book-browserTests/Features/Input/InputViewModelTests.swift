//
//  InputViewModelTests.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 30/11/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import XCTest
@testable import book_browser

class InputViewModelTests: XCTestCase {

    func testColorInterface() {
        let sut0 = InputViewModel()
        sut0.backgroundColor = UIColor.testColor0
        sut0.textBackgroundColor = UIColor.testColor1
        sut0.textColor = UIColor.testColor2
        
        XCTAssertEqual(sut0.backgroundColor, UIColor.testColor0)
        XCTAssertEqual(sut0.textBackgroundColor, UIColor.testColor1)
        XCTAssertEqual(sut0.textColor, UIColor.testColor2)
    }
    
    func testCallback() {
        let sut0 = InputViewModel()
        let expectedString = "any"
        let expectation = self.expectation(description: "For `onTextViewDone` to be called")
        
        sut0.onTextViewDone = { (string: String?) in
            guard string == expectedString else { return XCTFail("String attribute does not equal expected value") }
            
            expectation.fulfill()
        }
        sut0.onTextViewDone(expectedString)
        self.waitForExpectations(timeout: 0.1)
    }
}

private extension UIColor {
    
    static let testColor0 = UIColor(white: 1, alpha: 0)
    static let testColor1 = UIColor(white: 1, alpha: 0.1)
    static let testColor2 = UIColor(white: 1, alpha: 0.2)
}
