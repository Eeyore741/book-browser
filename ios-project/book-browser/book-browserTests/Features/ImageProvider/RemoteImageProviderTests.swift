//
//  RemoteImageProviderTests.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 13/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import XCTest
@testable import book_browser

class RemoteImageProviderTests: XCTestCase {

    func testInit() {
        let urlSesson = DummyUrlSession()
        let sut0 = RemoteImageProvider(urlSession: urlSesson)
        XCTAssertTrue(sut0.urlSession === urlSesson)
    }
    
    func testFill() throws {
        let imageView = UIImageView()
        let urlSession = DummyUrlSession()
        urlSession.delay = 0
        let sut0 = RemoteImageProvider(urlSession: urlSession)
        
        urlSession.behaviour = DummyUrlSession.Behaviour.fine(Data())
        sut0.fill(imageView: imageView, withImageByUrl: URL.dummy)
        self.expectation(description: "Wait a bit").isInverted = true
        self.waitForExpectations(timeout: 0.15)
        XCTAssertNil(imageView.image)
        
        urlSession.behaviour = DummyUrlSession.Behaviour.fail(self)
        sut0.fill(imageView: imageView, withImageByUrl: URL.dummy)
        self.expectation(description: "Wait a bit").isInverted = true
        self.waitForExpectations(timeout: 0.15)
        XCTAssertNil(imageView.image)
        
        let bundle = Bundle.init(for: Self.self)
        let url = try XCTUnwrap(bundle.url(forResource: "test-pic", withExtension: "png"))
        let data = try Data(contentsOf: url)
        urlSession.behaviour = DummyUrlSession.Behaviour.fine(data)
        sut0.fill(imageView: imageView, withImageByUrl: url)
        self.expectation(description: "Wait a bit").isInverted = true
        self.waitForExpectations(timeout: 0.15)
        XCTAssertNotNil(imageView.image)
    }
}

private extension URL {
    
    static let dummy: Self = URL(fileURLWithPath: "dummy")
}

/// Dummy conformance
extension RemoteImageProviderTests: Error { }
