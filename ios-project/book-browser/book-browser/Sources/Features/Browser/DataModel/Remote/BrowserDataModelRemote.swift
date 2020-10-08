//
//  BrowserDataModelRemote.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 27/09/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Type providing search API for `Storytel` service
/// example: "https://api.storytel.net/search?query=harry&page=10."
final class BrowserDataModelRemote {
    
    var state: BrowserDataModelState = .inactive(attributes: nil) {
        didSet {
            guard self.state != oldValue else { return }
            self.delegate?.dataModelStateChanged(self)
        }
    }
    
    weak var delegate: BrowserDataModelDelegate?
}

extension BrowserDataModelRemote: BrowserDataModel {
    
    func fetch(query: String?) {
        let session = URLSession.shared
        do {
            let bookListRequest = try BookListRequest(query: query, page: 0)
            session.dataTask(with: bookListRequest.request) { (data: Data?, response: URLResponse?, error: Error?) in
                guard let data = data else {
                    return self.state = BrowserDataModelState.error(error: BrowserDataError.fetch)
                }
                do {
                    let bookListResponse = try JSONDecoder().decode(BookListResponse.self, from: data)
                    let stateAttributes = (query: bookListResponse.query,
                                           books: bookListResponse.items,
                                           nextPageToken: bookListResponse.nextPageToken)
                    self.state = BrowserDataModelState.inactive(attributes: stateAttributes)
                } catch {
                    self.state = BrowserDataModelState.error(error: BrowserDataError.parse)
                }
            }.resume()
        } catch {
            self.state = BrowserDataModelState.error(error: BrowserDataError.request)
        }
    }
}
