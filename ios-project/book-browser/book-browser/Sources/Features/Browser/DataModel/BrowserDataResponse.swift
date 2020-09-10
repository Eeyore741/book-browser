//
//  BrowserDataResponse.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 29/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Type wrapping response content in case of success
struct BrowserDataResponse {
    
    let books: [BrowserDataBook]
    let query: String?
}

/// Conform to `Equatable` so encapsulating types can also conform
extension BrowserDataResponse: Equatable { }
