//
//  DummyBrowserDataModel.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 03/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

@testable import book_browser

final class DummyBrowserDataModel: BrowserDataModel {
    
    var onFetchHandler: (() -> Void)?
    
    func changeState(_ state: BrowserDataModelState) {
        self.state = state
    }
    
    var state: BrowserDataModelState = .inactive(attributes: nil) {
        didSet {
            self.delegate?.dataModelStateChanged(self)
        }
    }
    
    var delegate: BrowserDataModelDelegate?
    
    func fetch(query: String?) {
        self.onFetchHandler?()
    }
}
