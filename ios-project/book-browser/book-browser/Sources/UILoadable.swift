//
//  UILoadable.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 06/09/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Protocol descrives any type available for UI presenting
protocol UILoadable {
    
    /// Type instance loaded in UI and available for interaction
    func didLoad()
}
