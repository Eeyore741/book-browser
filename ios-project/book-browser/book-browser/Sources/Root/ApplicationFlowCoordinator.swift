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
        self.startRootFlow()
    }
    
    public func startRootFlow() {
        let vc = UIViewController(nibName: nil, bundle: nil)
        vc.view.backgroundColor = UIColor.purple
        self.navigationController.setViewControllers([vc], animated: true)
    }
    
    public func startInputFlow() {
        
    }
    
    public func startBookBrowserFlow() {
        
    }
}
