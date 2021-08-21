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
    var backgroundColor: UIColor = UIColor.darkGray
    var textBackgroundColor: UIColor = UIColor.darkGray
    var textColor: UIColor = UIColor.darkGray
    
    // Callbacks
    var onTextViewDone: ((String?) -> Void) = { _ in }
}
