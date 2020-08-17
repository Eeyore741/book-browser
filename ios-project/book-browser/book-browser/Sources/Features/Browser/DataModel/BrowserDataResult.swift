//
//  BrowserDataResult.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 17/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Alias wrapping result for browser data model
typealias BrowserDataResult = Result<[BrowserDataBook], BrowserDataError>
