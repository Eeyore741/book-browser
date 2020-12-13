//
//  LocalImageProviderTests.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 13/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import XCTest
@testable import book_browser

class LocalImageProviderTests: XCTestCase {
    
    func testInit() throws {
        try XCTAssertNoThrow(LocalImageProvider.init())
    }
    
    func testFill() throws {
        let sut0 = try LocalImageProvider()
        let imageView = UIImageView()
        
        sut0.fill(imageView: imageView, withImageByUrl: URL.dummy)
        XCTAssertNotNil(imageView.image)
    }
}

private extension URL {
    
    static let dummy: Self = URL(fileURLWithPath: "dummy")
}
