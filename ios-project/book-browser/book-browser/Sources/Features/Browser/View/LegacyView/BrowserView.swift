//
//  BrowserView.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 10/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// View displaying list of books
final class BrowserView: UIView {
    
    override class var requiresConstraintBasedLayout: Bool { true }
    
    private let tableView: UITableView = UITableView(frame: CGRect.zero)
    private let activityView: ActivityView = ActivityView()
    private let alertView: UILabel = UILabel()
    private var subviewsLayoutOnce: Bool = false
    
    public let viewModel: BrowserViewModel
    
    /// Designated initializer
    /// - Parameter viewModel: View model providing interface for view instance
    init(viewModel: BrowserViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        self.viewModel.delegate = self
        
        // Subviews & appearance
        self.backgroundColor = self.viewModel.backgroundColor
        self.addSubview(self.activityView)
        self.addSubview(self.tableView)
        self.addSubview(self.alertView)
        self.alertView.numberOfLines = 0
        self.alertView.textColor = UIColor.systemGray4
        self.alertView.isUserInteractionEnabled = true
        self.alertView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BrowserView.onAlertViewClick)))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(self.viewModel.cellType, forCellReuseIdentifier: self.viewModel.cellType.reuseIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.tableFooterView = {
            let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            view.startAnimating()
            return view
        }()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.subviewsLayoutOnce == false else { return }
        defer { self.subviewsLayoutOnce = true }
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.tableView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        self.activityView.translatesAutoresizingMaskIntoConstraints = false
        self.activityView.backgroundColor = UIColor.systemGray4
        NSLayoutConstraint.activate([
            self.activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.activityView.widthAnchor.constraint(equalToConstant: 90.0),
            self.activityView.heightAnchor.constraint(equalToConstant: 90.0)
        ])
        
        self.alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.alertView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.alertView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onAlertViewClick(_ sender: Any) {
        self.viewModel.onAlertClick()
    }
}

/// `BrowserView` is data source for itself to clear our model from redundant requirements
/// like being a `reference type` and conform to `NSObjectProtocol`
extension BrowserView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard tableView === self.tableView else { fatalError("Instance should only be a data source for itself") }
        
        return self.viewModel.numberOfConsumableItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard tableView === self.tableView else { fatalError("Instance should only be a data source for itself") }
        
        if self.viewModel.numberOfConsumableItems == indexPath.row + 1 {
            self.viewModel.fetch()
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.viewModel.cellType.reuseIdentifier, for: indexPath) as? BookCell {
            try? self.viewModel.fillCell(cell, withModelAtIndex: indexPath.row)
            return cell
        }
        fatalError("Undefined cell type")
    }
}

/// `BrowserView` is delegate for itself to clear our model from redundant requirements
/// like being a `reference type` and conform to `NSObjectProtocol`
extension BrowserView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView === self.tableView else { fatalError("Instance should only be a delegate for itself") }
        
        self.viewModel.onSelect() // TODO: do something?
    }
}

/// Private helper methods
private extension BrowserView {
    
    /// Lock/unlock view for user interaction with displaying of activity indicator
    /// - Parameter display: Lock or unlock
    func displayActivity() {
        guard self.activityView.superview != nil else { return }
        self.hideAllBut(self.activityView)
        
        self.bringSubviewToFront(self.activityView)
    }
    
    /// Present view with message in front
    /// - Parameter alert: Text in the center of view
    func displayAlert(_ alert: String) {
        guard self.alertView.superview != nil else { return }
        self.hideAllBut(self.alertView)
        
        self.alertView.text = alert
        self.bringSubviewToFront(self.alertView)
    }
    
    /// Present tableView
    func displayList(_ locked: Bool = false) {
        guard self.tableView.superview != nil else { return }
        self.isUserInteractionEnabled = !locked
        self.hideAllBut(self.tableView)
        
        self.bringSubviewToFront(self.tableView)
    }
    
    /// Hide all subviews setting `alpha` to `0` and disabling user interaction
    /// - Parameter exception: Subview that will not be affected by the function
    func hideAllBut(_ exception: UIView) {
        self.subviews.forEach { (view: UIView) in
            view.alpha = view === exception ? 1.0 : 0.0
        }
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
        
        DispatchQueue.main.async {
            switch self.viewModel.state {
            case .active:
                self.displayActivity()
            case .locked:
                self.displayList(true)
            case .alert(let message):
                self.displayAlert(message)
            case .inactive:
                self.displayList()
                self.tableView.reloadData()
            }
        }
    }
}

/// Private helper extension with file-only usefull functions
private extension UITableViewCell {
    
    class var reuseIdentifier: String {
        String(describing: self)
    }
}
