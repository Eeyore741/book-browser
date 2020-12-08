//
//  BookListRequestTests.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 30/11/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import XCTest
@testable import book_browser

class BookListRequestTests: XCTestCase {

    func testInit() throws {
        let sut0 = try BookListRequest(query: "query", page: "page")
        XCTAssertEqual(sut0.query, "query")
        XCTAssertEqual(sut0.page, "page")
        
        let testUrl = try XCTUnwrap(URL(string: "https://api.storytel.net/search?query=query&page=page"))
        let testRequest = URLRequest(url: testUrl, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 2)
        
        XCTAssertEqual(sut0.request, testRequest)
    }
}
