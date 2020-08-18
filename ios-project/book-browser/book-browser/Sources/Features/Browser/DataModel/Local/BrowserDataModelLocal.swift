//
//  BrowserDataModelLocal.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 17/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Local dummy data model fetching static data
struct BrowserDataModelLocal { }

/// Conform local data model to browser data model protocol
/// Exposing it for injection into book view model
extension BrowserDataModelLocal: BrowserDataModel {

    func fetch(query: String?, completionHandler: (BrowserDataResult) -> ()) {
        guard let jsonData = BrowserDataModelLocal.dummyJSON.data(using: String.Encoding.utf8) else {
            return completionHandler(BrowserDataResult.failure(BrowserDataError.fetch))
        }
        do {
            let models = try JSONDecoder().decode([BrowserDataBook].self, from: jsonData)
            completionHandler(BrowserDataResult.success(models))
        } catch {
            completionHandler(BrowserDataResult.failure(BrowserDataError.parse))
        }
    }
}

extension BrowserDataModelLocal {
    
    static var dummyJSON: String {
        """
        [
            {
                "id": "543990",
                "author": "Sonja Kaiblinger",
                "imageURL": "https://www.storytel.se/images/9783732005932/320x320/cover.jpg",
                "title": "Scary Harry: Fledermaus frei Haus"
            },
            {
                "id": "766269",
                "author": "Johnny Marciano",
                "imageURL": "https://www.storytel.se/images/9789877476026/320x320/cover.jpg",
                "title": "Garry. Enemigos"
            },
            {
                "id": "766271",
                "author": "J.K. Rowling",
                "imageURL": "https://www.storytel.se/images/9781781102374/320x320/cover.jpg",
                "title": "Garry. Enemigos"
            }
        ]
        """
    }
}
