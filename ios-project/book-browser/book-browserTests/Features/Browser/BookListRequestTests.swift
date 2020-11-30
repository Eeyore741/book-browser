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
        let sut0 = try BookListRequest(query: "q", page: "p")
        
    }
}
