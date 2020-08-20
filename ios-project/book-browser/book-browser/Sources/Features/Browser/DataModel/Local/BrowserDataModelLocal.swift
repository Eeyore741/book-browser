//
//  BrowserDataModelLocal.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 17/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Local dummy data model fetching static data
class BrowserDataModelLocal {
    
    var state: BrowserDataModelState = .inactive
}

/// Conform local data model to browser data model protocol
/// Exposing it for injection into book view model
extension BrowserDataModelLocal: BrowserDataModel {

    func fetch(query: String?, completionHandler: (BrowserDataResult) -> ()) {
        
        self.state = BrowserDataModelState.active
        guard let jsonData = BrowserDataModelLocal.dummyJSON.data(using: String.Encoding.utf8) else {
            let error = BrowserDataError.fetch
            self.state = BrowserDataModelState.error(error: error)
            completionHandler(BrowserDataResult.failure(error))
            return
        }
        do {
            let models = try JSONDecoder().decode([BrowserDataBook].self, from: jsonData)
            completionHandler(BrowserDataResult.success(models))
            self.state = BrowserDataModelState.inactive
        } catch {
            let error = BrowserDataError.parse
            self.state = BrowserDataModelState.error(error: error)
            completionHandler(BrowserDataResult.failure(error))
        }
    }
}

extension BrowserDataModelLocal {
    
    /// Dummy string describing JSON data
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
