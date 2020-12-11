//
//  RemoteImageProvider.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 08/11/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// Type provides functionality of fetching and caching remote images
/// Single task for every `UIImageView` being cached
/// Does not hold strog reference on `UIImageView` instances
final class RemoteImageProvider {
    
    let urlSession: URLSession
    
    private let imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    private let taskCache: NSMapTable<UIImageView, URLSessionDataTask> = NSMapTable<UIImageView, URLSessionDataTask>()
    
    /// Instantiate type with injection of `URLSession`
    /// - Parameter session: `URLSession` sessions sintance to handle data tasks
    init(urlSession: URLSession) {
        self.urlSession = urlSession
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
    
    func remoteDataTaskForImageView(_ imageView: UIImageView, withUrl url: URL) -> URLSessionDataTask {
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 3)
        let task = self.urlSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let data = data as Data?, let image = UIImage(data: data) {
                self.cacheImage(image, forUrl: url)
                DispatchQueue.main.async { imageView.image = image }
            }
        }
        return task
    }
}

extension RemoteImageProvider: ImageProvider {
    
    func fill(imageView: UIImageView, withImageByUrl url: URL) {
        if let cachedImage = self.cachedImage(forUrl: url) {
            return imageView.image = cachedImage
        }
        self.cachedTask(forImageView: imageView)?.cancel()
        let task = self.remoteDataTaskForImageView(imageView, withUrl: url)
        self.cacheTask(task, forImageView: imageView)
        task.resume()
    }
}
