//
//  BrowserDataModelState.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 20/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Type representing state of data model instance lifecycle
enum BrowserDataModelState {
    
    case inactive(response: BrowserDataResponse?) // Ready for calls
    case active // Instance performing task
    case error(error: BrowserDataError) // Inactive with error
}

extension BrowserDataModelState: Equatable { }
