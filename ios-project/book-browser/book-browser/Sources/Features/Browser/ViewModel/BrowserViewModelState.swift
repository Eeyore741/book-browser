//
//  BrowserViewModelState.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 20/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Type representing state of view model instance lifecycle
enum BrowserViewModelState {
    
    case inactive // Ready for user interaction
    case locked // User interaction disabled
    case active // Activity state unavailable for user interaction
    case alert(message: String) // Modal alert presenting state waiting for user decision
}

extension BrowserViewModelState: Equatable { }
