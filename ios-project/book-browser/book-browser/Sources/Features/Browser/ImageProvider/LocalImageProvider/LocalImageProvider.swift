//
//  LocalImageProvider.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 02/11/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// Local imaga provider type depending on local named resource
/// Dummy type exist to only conform `ImageProvider`
final class LocalImageProvider {
    
    private static let localImageResourceName: String = "nature"
    
    private let image: UIImage
    
    init() throws {
        guard let image = UIImage(named: Self.localImageResourceName) else {
            throw LocalImageProviderError.missingImageResource
        }
        self.image = image
    }
}

extension LocalImageProvider: ImageProvider {
    
    func fill(imageView: UIImageView, withImageByUrl url: URL) {
        imageView.image = self.image
    }
}
