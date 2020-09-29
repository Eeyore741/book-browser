//
//  BookListRequest.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 29/09/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Type describing request for list of books which title contains `query` string
/// url example: "https://api.storytel.net/search?query=harry&page=10."
struct BookListRequest {
    
    let query: String
    let page: Int
    let request: URLRequest
    
    /// Hiding unsupported initializing interface
    /// since `request` designed to be build  from `query` and `page`
    private init(query: String, page: Int, request: URLRequest) {
        fatalError("Unsupported initializer call")
    }
}

extension BookListRequest {
    
    /// Designated type initializer
    /// - Parameters:
    ///   - query: String used for in search of response items
    ///   - page: Search result page
    /// - Throws: `BrowserDataError` in case of unable to build `URLRequest`
    init(query: String, page: Int) throws {
        self.query = query
        self.page = page
        
        guard let url = URL(string: "https://api.storytel.net/search?query=\(query)&page=\(page)") else {
            throw BrowserDataError.request
        }
        self.request = URLRequest(url: url)
    }
}
