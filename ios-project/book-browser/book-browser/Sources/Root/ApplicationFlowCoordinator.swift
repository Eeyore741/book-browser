//
//  ApplicationFlowCoordinator.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 03/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// Application root flow coordinator
final class ApplicationFlowCoordinator: FlowCoordinator {
    
    var childFlowCoordinators: [FlowCoordinator] = []
    
    let window: UIWindow
    let navigationController: UINavigationController
    
    /// Target init for a type
    /// - Parameter window: Call expects window as a starting point for a flow
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController(nibName: nil, bundle: nil)
        self.navigationController.navigationBar.tintColor = UIColor.gray
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    /// Coordinator start call
    public func start() {
        self.startInputFlow()
    }
}

/// Type private calls extension
extension ApplicationFlowCoordinator {
    
    /// Flow requesting user preferable quiery parameter (optional)
    private func startInputFlow() {
        let inputFlow = InputFlowCoordinator(parentController: self.navigationController)
        inputFlow.onInputDone = { (text: String?) in
            inputFlow.finish {
                self.removeChildFlowCoordinator(inputFlow)
                self.startBookBrowserFlow(searchString: text)
            }
        }
        self.addChildFlowCoordinator(inputFlow)
        inputFlow.start()
    }
    
    /// Flow fetching & displaying list of book models to brows and single select
    /// - Parameter searchString: Optional query attribute to pass utilize in data fetching
    private func startBookBrowserFlow(searchString: String? = nil) {
        let browserFlow = BrowserFlowCoordinator(parentController: self.navigationController)
        self.addChildFlowCoordinator(browserFlow)
        browserFlow.start()
    }
}
