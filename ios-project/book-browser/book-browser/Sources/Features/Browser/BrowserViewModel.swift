//
//  BrowserModel.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 10/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// View model for browser view
struct BrowserViewModel {
    
    // Appearance
    var backgroundColor: UIColor = UIColor.blue
    
    // Fuctional
    var searchText: String = String()
    var cellType: UITableViewCell.Type = UITableViewCell.self
    var cellHeight: CGFloat = 0
    
    // Callback
    var onClose: (() -> Void) = { }
    var onSelect: (() -> Void) = { }
}
