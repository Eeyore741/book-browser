//
//  BookListResponse.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 29/09/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Response object expected to be used for decoding data in response for `BookListRequest`
struct BookListResponse {
    
    let query: String
    let filter: String
    let nextPageToken: String
    let totalCount: Int
    let items: [BrowserDataBook]
}

/// Conforming book model to `Decodable` getting functionality of
/// decoding model from raw data
extension BookListResponse: Decodable { }
