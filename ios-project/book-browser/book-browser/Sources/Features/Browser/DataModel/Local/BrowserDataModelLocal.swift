//
//  BrowserDataModelLocal.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 17/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Local dummy data model fetching static data
struct BrowserDataModelLocal {
    
}

/// Conform local data model to browser data model protocol
/// Exposing it for injection into book view model
extension BrowserDataModelLocal: BrowserDataModel {

    func fetch(query: String?, completionHandler: (BrowserDataResult) -> ()) {
        completionHandler(BrowserDataResult.failure(BrowserDataError.fetch))
    }
}
