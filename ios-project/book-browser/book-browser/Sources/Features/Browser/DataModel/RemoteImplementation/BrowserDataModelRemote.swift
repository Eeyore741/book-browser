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
            let bookListRequest = try BookListRequest(withBrowserDataModelState: self.state, andQuery: query)
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

private extension BookListRequest {
    
    /// Private convenience initializer useful in file scope only
    /// - Parameters:
    ///   - state: State of data model
    ///   - query: Request query
    /// - Throws: Throws en error if `state` attribute not equal to `inactive` case
    init(withBrowserDataModelState state: BrowserDataModelState, andQuery query: String?) throws {
        guard case let BrowserDataModelState.inactive(attributes) = state else { fatalError() }
        
        try self.init(query: query, page: attributes?.nextPageToken)
    }
}
