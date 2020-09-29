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
    
    var state: BrowserDataModelState = .inactive(response: nil) {
        didSet {
            guard self.state != oldValue else { return }
            self.delegate?.dataModelStateChanged(self)
        }
    }
    
    weak var delegate: BrowserDataModelDelegate?
}

extension BrowserDataModelRemote: BrowserDataModel {
    
    func fetch(query: String?) {
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession.shared //URLSession(configuration: config)
        do {
            let bookListRequest = try BookListRequest(query: query, page: 0)
            session.dataTask(with: bookListRequest.request) { (data: Data?, response: URLResponse?, error: Error?) in
                guard let data = data else {
                    return self.state = BrowserDataModelState.error(error: BrowserDataError.fetch)
                }
                let decoder = JSONDecoder()
                do {
                    let bookListResponse = try decoder.decode(BookListResponse.self, from: data)
                    let browserDataResponse = BrowserDataResponse.init(books: bookListResponse.items, query: query)
                    self.state = BrowserDataModelState.inactive(response: browserDataResponse)
                } catch {
                    self.state = BrowserDataModelState.error(error: BrowserDataError.parse)
                }
            }.resume()
        } catch {
            self.state = BrowserDataModelState.error(error: BrowserDataError.request)
        }
    }
}
