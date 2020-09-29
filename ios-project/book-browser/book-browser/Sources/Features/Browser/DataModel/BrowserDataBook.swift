//
//  BrowserDataBook.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 17/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Basic book model
struct BrowserDataBook {
    let id: String
    let author: String?
    let title: String
    let imageURL: String?
}

/// Conforming book model to `Codable` getting functionality of
/// decoding and encoding model from and into raw data
extension BrowserDataBook: Codable { }

/// Conforming book model to `Equatable` to be able to compare instances and types with generics filled with `BrowserDataBook`
extension BrowserDataBook: Equatable { }
