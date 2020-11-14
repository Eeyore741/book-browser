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
    let authors: [Author]?
    let title: String
    let cover: Cover?
    
    var authorNames: String? {
        self.authors?.reduce("By ", { $0 + $1.name + " " })
    }
}

/// Conforming book model to `Codable` getting functionality of
/// decoding and encoding model from and into raw data
extension BrowserDataBook: Codable { }

/// Conforming book model to `Equatable` to be able to compare instances and types with generics filled with `BrowserDataBook`
extension BrowserDataBook: Equatable { }

struct Cover {
    let url: String?
}

extension Cover: Codable { }
extension Cover: Equatable { }

struct Author {
    let name: String
}

extension Author: Codable { }
extension Author: Equatable { }
