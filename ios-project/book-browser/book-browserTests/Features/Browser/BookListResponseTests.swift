//
//  BookListResponseTests.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 08/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import XCTest
@testable import book_browser

final class BookListResponseTests: XCTestCase {

    func testInit() {
        let sut0 = BookListResponse(query: "query",
                                    filter: "filter",
                                    nextPageToken: "npt",
                                    totalCount: -1,
                                    items: [BrowserDataBook]())
        XCTAssertEqual(sut0.query, "query")
        XCTAssertEqual(sut0.filter, "filter")
        XCTAssertEqual(sut0.nextPageToken, "npt")
        XCTAssertEqual(sut0.totalCount, -1)
        XCTAssertEqual(sut0.items, [])
    }
    
    func testDecoding() throws {
        let data = try XCTUnwrap(String.bookListResponseRaw.data(using: String.Encoding.utf8))
        let sut0 = try JSONDecoder().decode(BookListResponse.self, from: data)
        
        XCTAssertEqual(sut0.query, "harry")
        XCTAssertEqual(sut0.filter, "books")
        XCTAssertEqual(sut0.nextPageToken, "10")
        XCTAssertEqual(sut0.totalCount, 1312)
        XCTAssertEqual(sut0.items, [])
    }
}

private extension String {
    
    static let bookListResponseRaw: Self =
    """
    {"query":"harry","filter":"books","nextPageToken":"10","totalCount":1312,"items":[]}
    """
}
