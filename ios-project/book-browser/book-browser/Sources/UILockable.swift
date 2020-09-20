//
//  UILockable.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 16/09/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

protocol UILockable {
    
    func lockUI(_ lock: Bool)
}

extension UILockable where Self: UIView {

    func lockUI(_ lock: Bool) {
        guard lock else { return self.activitySubviews.forEach { $0.removeFromSuperview() } }
        
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.addSubview(indicator)
        indicator.center = self.convert(self.center, from:self.superview)
        indicator.startAnimating()
    }
    
    private var activitySubviews: [UIActivityIndicatorView] {
        self.subviews.compactMap { (view: UIView) -> UIActivityIndicatorView? in
            view as? UIActivityIndicatorView
        }
    }
}
