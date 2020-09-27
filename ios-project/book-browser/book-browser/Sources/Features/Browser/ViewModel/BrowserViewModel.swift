//
//  BrowserModel.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 10/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// Delegate protocol for `BrowserViewModel` type instance callbacks handling
protocol BrowserViewModelDelegate {
    
    /// Called when view model state changed and new value is different from the old one
    /// - Parameter model: Model instance
    func viewModelStateChanged(_ model: BrowserViewModel)
}

/// View model for browser view
final class BrowserViewModel {
    
    var state: BrowserViewModelState = .inactive {
        didSet {
            guard self.state != oldValue else { return }
            self.delegate?.viewModelStateChanged(self)
        }
    }
    
    var delegate: BrowserViewModelDelegate?
    
    // Data
    private var dataModel: BrowserDataModel
    private var books: [BrowserDataBook] = [BrowserDataBook]()
    
    // Appearance
    var backgroundColor: UIColor = UIColor.white
    
    // Fuctional
    var searchText: String?
    var cellType: UITableViewCell.Type = BookCell.self
    
    // Callbacks
    var onClose: (() -> Void) = { }
    var onSelect: (() -> Void) = { }
    
    var numberOfConsumableItems: Int { self.books.count }
    
    init(dataModel: BrowserDataModel) {
        self.dataModel = dataModel
        self.dataModel.delegate = self
    }
    
    func fillCell(_ cell: BookCell, withModelAtIndex index: Int) throws {
        let model = self.books[index]
        cell.authorLabel.text = model.author
        cell.titleLabel.text = model.title
    }
    
    func refresh() {
        self.state = BrowserViewModelState.active
        self.dataModel.fetch(query: self.searchText)
    }
}

/// Make `BrowserViewModel` conform to `BrowserDataModelDelegate`
extension BrowserViewModel: BrowserDataModelDelegate {
    
    func dataModelStateChanged(_ model: BrowserDataModel) {
        switch model.state {
        case .active:
            self.state = BrowserViewModelState.active
        case .error(let error):
            let errorMessage = String(withBrowserDataError: error)
            self.state = BrowserViewModelState.alert(message: errorMessage)
        case .inactive(let response):
            if let response = response {
                self.books += response.books
            }
            self.state = BrowserViewModelState.inactive
        }
    }
}

/// File private `String` extension
private extension String {
    
    /// Convenience `String` builder utilizing module internal type
    /// - Parameter error: Data error to determine resulting string content error message
    init(withBrowserDataError error: BrowserDataError) {
        switch error {
        case .fetch:
            self = "Data fetch error"
        case .parse:
            self = "Data parse error"
        case .request:
            self = "Data request error"
        }
    }
}
