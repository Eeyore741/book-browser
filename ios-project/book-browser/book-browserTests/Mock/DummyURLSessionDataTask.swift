//
//  DummyURLSessionDataTask.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 11/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

final class DummyURLSessionDataTask: URLSessionDataTask {
    
    override func resume() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.delay) {
            self.onResume()
        }
    }
    
    /// Dummy helpers
    var delay: TimeInterval = 1
    
    var onResume: () -> Void = { }
}
