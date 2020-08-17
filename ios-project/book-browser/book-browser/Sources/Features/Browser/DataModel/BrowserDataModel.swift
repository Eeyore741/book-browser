//
//  BrowserDataModel.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 17/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Protocol describing data model for browser view model
protocol BrowserDataModel {
    
    func fetch(query: String?, completionHandler: (BrowserDataResult) -> ())
}
