//
//  InputViewModel.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 05/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// View model type for input view
final class InputViewModel {
    
    // Setup
    var backgroundColor: (() -> (UIColor)) = { UIColor.yellow }
    var textBackgroundColor: (() -> (UIColor)) = { UIColor.lightText }
    var textColor: (() -> (UIColor)) = { UIColor.darkGray }
    
    // Callbacks
    var onTextViewDone: ((String?) -> ()) = { _ in }
}
