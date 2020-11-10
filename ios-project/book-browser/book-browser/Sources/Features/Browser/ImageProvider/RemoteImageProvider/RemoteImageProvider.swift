//
//  RemoteImageProvider.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 08/11/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

final class RemoteImageProvider {
    
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
}

extension RemoteImageProvider: ImageProvider {
    
    func fill(imageView: UIImageView, withImageByUrl url: URL) {
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 13)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            switch (data, error) {
            case let (data, .some(error)) where data == nil:
                fatalError(error.localizedDescription)
            case let (.some(data), error) where error == nil:
                guard let image = UIImage(data: data) else {
                    fatalError("unable to init image")
                }
                DispatchQueue.main.async { imageView.image = image }
            default:
                fatalError("undefined")
            }
        }.resume()
    }
}
