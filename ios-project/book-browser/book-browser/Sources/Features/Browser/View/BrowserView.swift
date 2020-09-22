//
//  BrowserView.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 10/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

final class BrowserView: UITableView {
    
    override class var requiresConstraintBasedLayout: Bool { true }
    
    private let activityView: ActivityView = ActivityView()
    private var subviewsLayoutOnce: Bool = false
    
    public let viewModel: BrowserViewModel
    
    init(viewModel: BrowserViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero, style: UITableView.Style.plain)
        self.viewModel.delegate = self
        self.dataSource = self
        self.delegate = self
        
        // Subviews & appearance
        self.backgroundColor = self.viewModel.backgroundColor
        self.addSubview(self.activityView)
        self.register(self.viewModel.cellType, forCellReuseIdentifier: self.viewModel.cellType.reuseIdentifier)
        self.rowHeight = UITableView.automaticDimension
        self.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// `BrowserView` is data source for itself to clear our model from redundant requirements
/// like being a `reference type` and conform to `NSObjectProtocol`
extension BrowserView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard tableView === self else { fatalError("Instance should only be a data source for itself") }
        
        return self.viewModel.numberOfConsumableItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard tableView === self else { fatalError("Instance should only be a data source for itself") }
        
        return tableView.dequeueReusableCell(withIdentifier: self.viewModel.cellType.reuseIdentifier, for: indexPath)
    }
}

/// `BrowserView` is delegate for itself to clear our model from redundant requirements
/// like being a `reference type` and conform to `NSObjectProtocol`
extension BrowserView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView === self else { fatalError("Instance should only be a delegate for itself") }
        
        self.viewModel.onSelect() // TODO: fill with model
    }
}


/// Conform `BrowserView` so view may react on its UI load event
extension BrowserView: UILoadable {
    
    func didLoad() {
        self.viewModel.refresh()
    }
}

/// Conform so `BrowserView` can be a delegate for own view model
extension BrowserView: BrowserViewModelDelegate {
    
    /// React on view model state changed
    /// - Parameter model: View model
    func viewModelStateChanged(_ model: BrowserViewModel) {
        guard model === self.viewModel else { fatalError("Instance should only be delegate for own model") }
        
        switch model.state {
        case .active:
            assertionFailure()
        case .alert(let message):
            assertionFailure()
        case .inactive:
            assertionFailure()
        }
    }
}

/// Private helper extension with file-only usefull functions
private extension UITableViewCell {
    
    class var reuseIdentifier: String {
        String(describing: self)
    }
}

extension BrowserView: UILockable { }
