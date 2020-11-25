//
//  FlowCoordinator.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 03/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Basic flow coordinator reference type able to contain child flow coordinators
protocol FlowCoordinator: class {
    
    var childFlowCoordinators: [FlowCoordinator] { get set }
}


extension FlowCoordinator {
    
    /// Add new flow coordinator as a child for current instance
    /// - Parameter flowCoordinator: Flow coordinator to add as child one
    func addChildFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        guard self.childFlowCoordinators.contains(where: { $0 === flowCoordinator }) == false else { return }
        self.childFlowCoordinators.append(flowCoordinator)
    }
    
    /// Try to remove child flow coordinator from current instance
    /// - Parameter flowCoordinator: Child flow coordinator to remove
    func removeChildFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        self.childFlowCoordinators.removeAll { $0 === flowCoordinator }
    }
}
