//
//  DummyUrlSession.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 11/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

final class DummyUrlSession: URLSession {
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let task = DummyURLSessionDataTask()
        task.delay = self.delay
        
        switch self.behaviour {
        case let .fine(data):
            task.onResume = { completionHandler(data, nil, nil) }
        case let .fail(error):
            task.onResume = { completionHandler(nil, nil, error) }
        }

        return task
    }
    
    /// Dummy helpers
    enum Behaviour {
        case fine(Data)
        case fail(Error)
    }
    
    var behaviour: Behaviour = .fine(Data())
    
    var delay: TimeInterval = 1
    
    var onDataTask: ((URLRequest, (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) = { _,_ in fatalError("Unexpected behaviour") }
}
