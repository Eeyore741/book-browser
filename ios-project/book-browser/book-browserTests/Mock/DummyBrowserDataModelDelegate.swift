//
//  DummyBrowserDataModelDelegate.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 23/10/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation
@testable import book_browser

final class DummyBrowserDataModelDelegate: BrowserDataModelDelegate {
    
    var onDataModelStateChanged: ((BrowserDataModel) -> Void)?
    
    func dataModelStateChanged(_ model: BrowserDataModel) {
        self.onDataModelStateChanged?(model)
    }
}
