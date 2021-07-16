//
//  BookView.swift
//  book-browser
//
//  Created by vitalii.kuznetsov on 2021-07-15.
//  Copyright © 2021 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

final class BookView: UIView {
    
    class override var requiresConstraintBasedLayout: Bool { true }
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.textColor = UIColor.darkGray
        return view
    }()
    
    lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.textColor = UIColor.lightGray
        return view
    }()
    
    lazy var coverView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()
    
    private var constraintsLayoutOnce: Bool = false

    override func updateConstraints() {
        super.updateConstraints()
        
        guard self.constraintsLayoutOnce == false else { return }
        defer { self.constraintsLayoutOnce = true }
        
        [self.titleLabel, self.authorLabel, self.coverView].forEach { (subview: UIView) in
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            self.coverView.widthAnchor.constraint(equalToConstant: Layout.coverViewSide),
            self.coverView.heightAnchor.constraint(equalToConstant: Layout.coverViewSide),
            self.coverView.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor),
            self.coverView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.coverView.layoutMarginsGuide.trailingAnchor, multiplier: 2.0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.authorLabel.topAnchor.constraint(equalTo: self.titleLabel.layoutMarginsGuide.bottomAnchor, constant: Layout.authorLabelTopInset),
            self.authorLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.coverView.layoutMarginsGuide.trailingAnchor, multiplier: 2.0),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

/// Private type wrapping appearance constants
private enum Layout {
    
    static let authorLabelTopInset: CGFloat = 8.0
    static let coverViewSide: CGFloat = 44.0
}

