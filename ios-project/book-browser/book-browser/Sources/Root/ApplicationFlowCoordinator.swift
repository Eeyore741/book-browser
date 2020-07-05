//
//  ApplicationFlowCoordinator.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 03/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

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
}

extension ApplicationFlowCoordinator {
    
    public func start() {
        self.startInputFlow()
    }

    private func startInputFlow() {
        let inputFlow = InputFlowCoordinator(parentController: self.navigationController)
        inputFlow.onInputDone = { (text: String?) in
            inputFlow.finish {
                self.startBookBrowserFlow(searchString: text)
            }
            self.removeChildFlowCoordinator(inputFlow)
        }
        addChildFlowCoordinator(inputFlow)
        inputFlow.start()
    }
    
    private func startBookBrowserFlow(searchString: String? = nil) {
        
    }
}
