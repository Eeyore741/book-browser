//
//  BrowserDataModelRemoteTests.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 08/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import XCTest
@testable import book_browser

class BrowserDataModelRemoteTests: XCTestCase {

    func testFetchError() {
        let urlSession = DummyUrlSession()
        urlSession.behaviour = .fail(self)
        urlSession.delay = 0.1
        
        let sut0 = BrowserDataModelRemote(urlSession: urlSession)
        XCTAssertEqual(sut0.state, BrowserDataModelState.inactive(attributes: nil))
        sut0.fetch(query: "any")
        
        self.expectation(description: "Wait a bit").isInverted = true
        self.waitForExpectations(timeout: 0.25)
        
        XCTAssertEqual(sut0.state, BrowserDataModelState.error(error: BrowserDataError.fetch))
    }
    
    func testParseError() {
        let urlSession = DummyUrlSession()
        urlSession.behaviour = .fine(Data())
        urlSession.delay = 0.1
        
        let sut0 = BrowserDataModelRemote(urlSession: urlSession)
        XCTAssertEqual(sut0.state, BrowserDataModelState.inactive(attributes: nil))
        sut0.fetch(query: "any")
        
        self.expectation(description: "Wait a bit").isInverted = true
        self.waitForExpectations(timeout: 0.25)
        
        XCTAssertEqual(sut0.state, BrowserDataModelState.error(error: BrowserDataError.parse))
    }
    
    func testRequestError() {
        let urlSession = DummyUrlSession()
        urlSession.behaviour = .fine(Data())
        urlSession.delay = 0.1
        
        let sut0 = BrowserDataModelRemote(urlSession: urlSession)
        sut0.bookListRequestProvider = { _, _ in
            throw self
        }
        XCTAssertEqual(sut0.state, BrowserDataModelState.inactive(attributes: nil))
        sut0.state = BrowserDataModelState.error(error: BrowserDataError.request)
        sut0.fetch(query: "any")
        
        self.expectation(description: "Wait a bit").isInverted = true
        self.waitForExpectations(timeout: 0.25)
        
        XCTAssertEqual(sut0.state, BrowserDataModelState.error(error: BrowserDataError.request))
    }
    
    func testFetchFine() {
        guard let data = String.bookListJson.data(using: String.Encoding.utf8) else { fatalError() }
        
        let urlSession = DummyUrlSession()
        urlSession.behaviour = .fine(data)
        urlSession.delay = 0
        
        let sut0 = BrowserDataModelRemote(urlSession: urlSession)
        XCTAssertEqual(sut0.state, BrowserDataModelState.inactive(attributes: nil))
        
        sut0.fetch(query: "any")
        self.expectation(description: "Wait a bit").isInverted = true
        self.waitForExpectations(timeout: 0.25)
        
        let testBook = BrowserDataBook(id: "any id", authors: [Author(name: "any name")], title: "any title", cover: Cover(url: "any link"))
        let state = BrowserDataModelState.inactive(attributes: (query: "any", books: [testBook], nextPageToken: "10"))
        XCTAssertEqual(sut0.state, state)
    }
}

/// Dummy conformance for test purposes
extension BrowserDataModelRemoteTests: Error { }

private extension String {
    
    static let bookListJson: Self =
    """
    {"query":"any","filter":"books","nextPageToken":"10","totalCount":1319,"items":[{"id":"any id","title":"any title","authors":[{"name":"any name"}],"cover":{"url":"any link"}}]}
    """
}
