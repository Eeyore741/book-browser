//
//  InputFlowCoordinator.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 03/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// Flow coordinator to handle user text input 
final class InputFlowCoordinator: FlowCoordinator {
    
    var childFlowCoordinators: [FlowCoordinator] = []
    
    weak var parentController: UINavigationController?
    private var viewController: UIViewController?
    
    /// Handler called when flow is completed with optional `String` result
    var onInputDone: ((String?) -> ())?
    
    init(parentController: UINavigationController) {
        self.parentController = parentController
    }
    
    public func start() {
        let model = InputViewModel()
        model.backgroundColor = UIColor.systemGray6
        model.textBackgroundColor = UIColor.lightText
        model.textColor = UIColor.darkGray
        model.onTextViewDone = { (text: String?) in
            self.onInputDone?(text)
        }
        
        let view = InputView(viewModel: model)
        let controller = BasicViewController(view: view)
        controller.modalPresentationStyle = .fullScreen
        
        self.parentController?.pushViewController(controller, animated: true)
        self.viewController = controller
        self.viewController?.navigationItem.title = "Input"
    }
    
    public func finish(completionHandler: (() -> Void)? = nil) {
        self.viewController?.dismiss(animated: false, completion: completionHandler)
    }
}
