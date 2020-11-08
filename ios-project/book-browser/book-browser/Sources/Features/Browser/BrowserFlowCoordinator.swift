//
//  BrowserFlowCoordinator.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 03/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// Flow coordinator handling books list displaying and user list interactions
final class BrowserFlowCoordinator: FlowCoordinator {
    
    var childFlowCoordinators: [FlowCoordinator] = []
    
    weak var parentController: UINavigationController?
    private var viewController: UIViewController?
    
    var onClose: ((String?) -> ())?
    var onSelection: ((String?) -> ())?
    
    private var query: String?
    
    init(parentController: UINavigationController, query: String? = nil) {
        self.parentController = parentController
        self.query = query
    }
    
    public func start() {
        do {
            let imageProvider = try LocalImageProvider()
            let dataModel = BrowserDataModelRemote()
            let viewModel = BrowserViewModel(dataModel: dataModel, imageProvider: imageProvider)
            viewModel.searchText = self.query
            let view = BrowserView(viewModel: viewModel)
            let controller = BasicViewController(view: view)
            controller.navigationItem.title = "Search: \(self.query.unsafelyUnwrapped)"
            self.parentController?.pushViewController(controller, animated: true)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func finish() {
        assertionFailure("undefined")
    }
}
