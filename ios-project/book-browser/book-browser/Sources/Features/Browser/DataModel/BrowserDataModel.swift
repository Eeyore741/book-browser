//
//  BrowserDataModel.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 17/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

protocol BrowserDataModelDelegate {
    
    func onDataModelStateChanged(_ model: BrowserDataModel)
}

/// Protocol describing data model for browser view model
protocol BrowserDataModel {
    
    /// Read only state of instance
    var state: BrowserDataModelState { get }
    
    /// Fetch `book` models
    /// - Parameters:
    ///   - query: Attribute utilized in fetch call for matching `book` name
    ///   - completionHandler: Attribute handling fetch task completion
    func fetch(query: String?, completionHandler: (BrowserDataResult) -> ())
}
