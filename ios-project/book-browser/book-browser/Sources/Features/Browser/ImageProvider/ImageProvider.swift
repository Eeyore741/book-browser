//
//  ImageProvider.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 02/11/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// Protocol providing functionality for setting remote images 
protocol ImageProvider {
    
    func fill(imageView: UIImageView, withImageByUrl url: URL)
}
