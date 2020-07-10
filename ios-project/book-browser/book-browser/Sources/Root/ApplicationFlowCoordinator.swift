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
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController(nibName: nil, bundle: nil)
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

    private func startInputFlow() {
        let inputFlow = InputFlowCoordinator(parentController: self.navigationController)
        inputFlow.onInputDone = { (text: String?) in
            inputFlow.finish {
                self.removeChildFlowCoordinator(inputFlow)
                self.startBookBrowserFlow(searchString: text)
            }
        }
        addChildFlowCoordinator(inputFlow)
        inputFlow.start()
    }
    
    private func startBookBrowserFlow(searchString: String? = nil) {
        
    }
}
