//
//  BrowserViewModelTests.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 03/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import XCTest
@testable import book_browser

class BrowserViewModelTests: XCTestCase {
    
    func testModelStates() {
        let dataModel = DummyBrowserDataModel()
        let imageProvider = DummyImageProvider()
        let sut0 = BrowserViewModel(dataModel: dataModel, imageProvider: imageProvider)
        
        XCTAssertEqual(sut0.state, BrowserViewModelState.inactive)
        
        sut0.refresh()
        XCTAssertEqual(sut0.state, BrowserViewModelState.active)
        
        sut0.fetch()
        XCTAssertEqual(sut0.state, BrowserViewModelState.locked)
        
        dataModel.changeState(BrowserDataModelState.error(error: BrowserDataError.fetch))
        XCTAssertEqual(sut0.state, BrowserViewModelState.alert(message: "Data fetch error"))
        
        dataModel.changeState(BrowserDataModelState.error(error: BrowserDataError.parse))
        XCTAssertEqual(sut0.state, BrowserViewModelState.alert(message: "Data parse error"))
        
        dataModel.changeState(BrowserDataModelState.error(error: BrowserDataError.request))
        XCTAssertEqual(sut0.state, BrowserViewModelState.alert(message: "Data request error"))
    }
    
    func testDelegateCallbacks() {
        let dataModel = DummyBrowserDataModel()
        let imageProvider = DummyImageProvider()
        let delegate = DummyBrowserViewModelDelegate()
        let sut0 = BrowserViewModel(dataModel: dataModel, imageProvider: imageProvider)
        sut0.delegate = delegate
        
        XCTAssertEqual(sut0.state, BrowserViewModelState.inactive)
        
        var expectation = self.expectation(description: "Expect view model to not to trigger state update with same state")
        expectation.isInverted = true
        delegate.onViewModelStateChanged = {
            expectation.fulfill()
        }
        sut0.state = BrowserViewModelState.inactive
        self.waitForExpectations(timeout: 0.1)
        
        expectation = self.expectation(description: "Expect view model to trigger state update on delegate")
        expectation.isInverted = false
        delegate.onViewModelStateChanged = {
            expectation.fulfill()
        }
        sut0.state = BrowserViewModelState.active
        self.waitForExpectations(timeout: 0.1)
        
        expectation = self.expectation(description: "Expect view model to trigger state update on delegate")
        expectation.isInverted = false
        delegate.onViewModelStateChanged = {
            expectation.fulfill()
        }
        sut0.state = BrowserViewModelState.alert(message: "any")
        self.waitForExpectations(timeout: 0.1)
        
        expectation = self.expectation(description: "Expect view model to trigger state update on delegate")
        expectation.isInverted = false
        delegate.onViewModelStateChanged = {
            expectation.fulfill()
        }
        sut0.state = BrowserViewModelState.locked
        self.waitForExpectations(timeout: 0.1)
    }
    
    func testMiscInterface() {
        let dataModel = DummyBrowserDataModel()
        let imageProvider = DummyImageProvider()
        let delegate = DummyBrowserViewModelDelegate()
        let sut0 = BrowserViewModel(dataModel: dataModel, imageProvider: imageProvider)
        sut0.delegate = delegate
        
        XCTAssertEqual(sut0.backgroundColor, UIColor.white)
        
        sut0.backgroundColor = UIColor.black
        XCTAssertEqual(sut0.backgroundColor, UIColor.black)
        
        sut0.searchText = "any"
        XCTAssertEqual(sut0.searchText, "any")
        
        
        XCTAssertEqual(String(describing: sut0.cellType), "BookCell")
        sut0.cellType = UITableViewCell.self
        XCTAssertEqual(String(describing: sut0.cellType), "UITableViewCell")
        
        let expectation = self.expectation(description: "For data model fetch triggered on view model alert click handler call")
        dataModel.onFetchHandler = {
            expectation.fulfill()
        }
        sut0.onAlertClick()
        self.waitForExpectations(timeout: 0.1)
        
        dataModel.changeState(BrowserDataModelState.inactive(attributes: (nil, [BrowserDataBook](), "any")))
    }
    
    func testNumberOfConsumableItems() {
        let dataModel = DummyBrowserDataModel()
        let imageProvider = DummyImageProvider()
        let sut0 = BrowserViewModel(dataModel: dataModel, imageProvider: imageProvider)
        
        XCTAssertEqual(sut0.numberOfConsumableItems, 0)
        
        let book = BrowserDataBook(id: "any id", authors: nil, title: "any title", cover: nil)
        let attributes = BrowserDataModelInactiveAttributes(nil, [book], "any")
        dataModel.state = BrowserDataModelState.inactive(attributes: attributes)
        
        XCTAssertEqual(sut0.numberOfConsumableItems, 1)
    }
    
    func testFillCell() throws {
        let dataModel = DummyBrowserDataModel()
        let imageProvider = DummyImageProvider()
        let sut0 = BrowserViewModel(dataModel: dataModel, imageProvider: imageProvider)
        
        let author0 = Author(name: "Foo Bar")
        let author1 = Author(name: "John Doe")
        let cover = Cover(url: "http://any.link")
        let book = BrowserDataBook(id: "1", authors: [author0, author1], title: "Any Book", cover: cover)
        
        let attributes = BrowserDataModelInactiveAttributes(nil, [book], "any")
        dataModel.state = BrowserDataModelState.inactive(attributes: attributes)
        
        let cell = BookCell()
        try sut0.fillCell(cell, withModelAtIndex: 0)
        
        self.expectation(description: "Wait a bit").isInverted = true
        self.waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(cell.authorLabel.text, "By Foo Bar John Doe ")
        XCTAssertEqual(cell.titleLabel.text, "Any Book")
        XCTAssertEqual(cell.coverView.image, imageProvider.image)
    }
}
