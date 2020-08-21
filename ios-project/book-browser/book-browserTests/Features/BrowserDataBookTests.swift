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
        XCTAssertEqual(sut0.author, "any author")
        XCTAssertEqual(sut0.imageURL, "anyLink")
    }
    
    func testEncoding() throws {
        let sut0 = BrowserDataBook(id: "any id", author: "any author", title: "any title", imageURL: "anyLink")
        
        let sut1: Data = try self.encoder.encode(sut0)
        let sut2: String = try XCTUnwrap(String(data: sut1, encoding: String.Encoding.utf8))
        
        XCTAssertEqual(sut2, BrowserDataBookTests.bookJSON.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
    }
}

private extension BrowserDataBookTests {
    
    static var bookJSON: String {
        """
        {"id":"any id","author":"any author","title":"any title","imageURL":"anyLink"}
        """
    }
}
