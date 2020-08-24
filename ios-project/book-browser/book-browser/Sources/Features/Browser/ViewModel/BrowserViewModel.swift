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
    func viewModelDidChangeState(_ model: BrowserViewModel)
}

/// View model for browser view
final class BrowserViewModel {
    
    var state: BrowserViewModelState = .inactive {
        didSet {
            guard self.state != oldValue else { return }
            self.delegate?.viewModelDidChangeState(self)
        }
    }
    
    var delegate: BrowserViewModelDelegate?
    
    // Data
    var dataModel: BrowserDataModel
    
    // Appearance
    var backgroundColor: UIColor = UIColor.blue
    
    // Fuctional
    var searchText: String = String()
    var cellType: UITableViewCell.Type = UITableViewCell.self
    var cellHeight: CGFloat = 0
    
    // Callbacks
    var onClose: (() -> Void) = { }
    var onSelect: (() -> Void) = { }
    
    init(dataModel: BrowserDataModel) {
        self.dataModel = dataModel
        self.dataModel.delegate = self
    }
}

/// Make `BrowserViewModel` conform to `BrowserDataModelDelegate`
extension BrowserViewModel: BrowserDataModelDelegate {
    
    func onDataModelStateChanged(_ model: BrowserDataModel) {
        assertionFailure()
    }
}
