//
//  BrowserDataModelState.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 20/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

typealias BrowserDataModelInactiveAttributes = (query: String?, books: [BrowserDataBook], nextPageToken: String)

/// Type representing state of data model instance lifecycle
enum BrowserDataModelState {
    
    case inactive(attributes: BrowserDataModelInactiveAttributes?) // Ready for calls
    case active // Instance performing task
    case error(error: BrowserDataError) // Inactive with error
}

extension BrowserDataModelState: Equatable {
    static func == (lhs: BrowserDataModelState, rhs: BrowserDataModelState) -> Bool {
        switch (lhs, rhs) {
        case (.active, .active):
            return true
        case let (.error(lhsError), .error(rhsError)):
            return lhsError == rhsError
        case let (.inactive(lhsAttributes), .inactive(rhsAttributes)):
            return lhsAttributes?.query == rhsAttributes?.query && lhsAttributes?.books == rhsAttributes?.books && lhsAttributes?.nextPageToken == rhsAttributes?.nextPageToken
        default:
            return false
        }
    }
}
