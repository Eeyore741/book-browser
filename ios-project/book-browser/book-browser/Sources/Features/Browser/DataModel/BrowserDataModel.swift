//
//  BrowserDataModel.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 17/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Reference type protocol wrapping `BrowserDataModel` callbacks
protocol BrowserDataModelDelegate: AnyObject {
    
    /// Called when view model state changed and new value is different from the old one
    /// - Parameter model: Model instance
    func dataModelStateChanged(_ model: BrowserDataModel)
}

/// Protocol describing data model for browser view model
protocol BrowserDataModel {
    
    /// Read only state of instance
    var state: BrowserDataModelState { get }
    
    /// Delegate reference type
    var delegate: BrowserDataModelDelegate? { get set }
    
    /// Fetch `book` models
    /// - Parameters:
    ///   - query: Attribute utilized in fetch call for matching `book` name
    func fetch(query: String?)
}
