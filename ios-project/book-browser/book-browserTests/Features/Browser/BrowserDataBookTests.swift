//
//  BrowserDataBookTests.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 21/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import XCTest
@testable import book_browser

/// Type wrapping tests for `BrowserDataBookTests` type
final class BrowserDataBookTests: XCTestCase {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func testDecoding() throws {
        let data = try XCTUnwrap(BrowserDataBookTests.bookJSON.data(using: String.Encoding.utf8))
        let sut0 = try self.decoder.decode(BrowserDataBook.self, from: data)
        
        XCTAssertEqual(sut0.id, "any id")
        XCTAssertEqual(sut0.title, "any title")
        XCTAssertFalse(try XCTUnwrap(sut0.authors).isEmpty)
//        XCTAssertEqual(sut0.imageURL, "anyLink")
    }
    
    func testEncoding() throws {
        let author = Author(name: "any name")
        let cover = Cover(url: "any link")
        let sut0 = BrowserDataBook(id: "any id", authors: [author], title: "any title", cover: cover)
        
        let sut1: Data = try self.encoder.encode(sut0)
        let sut2: String = try XCTUnwrap(String(data: sut1, encoding: String.Encoding.utf8))
        
        XCTAssertEqual(sut2, BrowserDataBookTests.bookJSON.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
    }
}

private extension BrowserDataBookTests {
    
    static var bookJSON: String {
        """
        {"id":"any id","title":"any title","authors":[{"name":"any name"}],"cover":{"url":"any link"}}
        """
    }
}
