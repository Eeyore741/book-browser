//
//  DummyBrowserViewModelDelegate.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 03/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation
@testable import book_browser

final class DummyBrowserViewModelDelegate: BrowserViewModelDelegate {
    
    var onViewModelStateChanged: (() -> Void)?
    var delay: TimeInterval = 0
    
    func viewModelStateChanged(_ model: BrowserViewModel) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.delay) {
            self.onViewModelStateChanged?()
        }
    }
}
