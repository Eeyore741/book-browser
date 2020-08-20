//
//  BrowserDataError.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 17/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Type holding possible error cases for browser data model functionality
enum BrowserDataError: Error {
    
    case fetch // Describe cases when data fetch is not possible
    case parse // Describe cases when data fetched but parsing into models is not possible
}
