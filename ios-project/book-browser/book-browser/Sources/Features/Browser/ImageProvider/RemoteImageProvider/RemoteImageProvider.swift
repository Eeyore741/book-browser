//
//  RemoteImageProvider.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 08/11/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

final class RemoteImageProvider {
    
    private let session: URLSession
    private let imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    private let taskCache: NSMapTable<UIImageView, URLSessionDataTask> = NSMapTable<UIImageView, URLSessionDataTask>()
    
    init(session: URLSession) {
        self.session = session
    }
    
    func cachedImage(forUrl url: URL) -> UIImage? {
        self.imageCache.object(forKey: NSString(string: url.absoluteString))
    }
    
    func cacheImage(_ image: UIImage, forUrl url: URL) {
        self.imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
    }
    
    func cachedTask(forImageView imageView: UIImageView) -> URLSessionDataTask? {
        self.taskCache.object(forKey: imageView)
    }
    
    func cacheTask(_ task: URLSessionDataTask, forImageView imageView: UIImageView) {
        self.taskCache.setObject(task, forKey: imageView)
    }
}

extension RemoteImageProvider: ImageProvider {
    
    func fill(imageView: UIImageView, withImageByUrl url: URL) {
        if let cachedImage = self.cachedImage(forUrl: url) {
            return imageView.image = cachedImage
        }
        self.cachedTask(forImageView: imageView)?.cancel()
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 13)
        let task = self.session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error as NSError?, error.code == .taskCanceledErrorCode { return }
            switch (data, error) {
            case let (data, .some(error)) where data == nil:
                fatalError(error.localizedDescription)
            case let (.some(data), error) where error == nil:
                guard let image = UIImage(data: data) else {
                    fatalError("unable to init image")
                }
                self.cacheImage(image, forUrl: url)
                DispatchQueue.main.async { imageView.image = image }
            default:
                fatalError("undefined")
            }
        }
        self.cacheTask(task, forImageView: imageView)
        task.resume()
    }
}

private extension Int {
    
    static let taskCanceledErrorCode: Self = -999
}
