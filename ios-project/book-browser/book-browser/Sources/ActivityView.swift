//
//  ActivityView.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 20/09/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// View to display activity indicator
final class ActivityView: UIView {
    
    class override var requiresConstraintBasedLayout: Bool { true }
    
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    private var subviewsLayoutOnce: Bool = false
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.size.width / 10.0
        
        guard self.subviewsLayoutOnce == false else { return }
        defer { self.subviewsLayoutOnce = true }
        
        self.indicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.indicator)
        NSLayoutConstraint.activate([
            self.indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        self.indicator.startAnimating()
    }
}
