//
//  DummyImageProvider.swift
//  book-browserTests
//
//  Created by Vitalii Kuznetsov on 03/12/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit
@testable import book_browser

final class DummyImageProvider: ImageProvider {
    
    var delay: TimeInterval = 0
    
    lazy var image: UIImage = {
        guard let path = Bundle(for: type(of: self)).path(forResource: "test-pic", ofType: "png"),
            let image = UIImage(contentsOfFile: path) else { fatalError("Named resource not found") }
        return image
    }()
    
    func fill(imageView: UIImageView, withImageByUrl url: URL) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.delay) {
            imageView.image = self.image
        }
    }
}
