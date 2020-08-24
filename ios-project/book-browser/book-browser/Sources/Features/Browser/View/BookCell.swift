//
//  BookCell.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 24/08/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

/// Simple cell type to display title and author
final class BookCell: UITableViewCell {
    
    static override var requiresConstraintBasedLayout: Bool { true }
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textColor = UIColor.darkGray
        return view
    }()
    
    lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textColor = UIColor.lightGray
        return view
    }()
    
    private var constraintsLayoutOnce: Bool = false
    
    override func updateConstraints() {
        super.updateConstraints()
        
        guard self.constraintsLayoutOnce == false else { return }
        defer { self.constraintsLayoutOnce = true }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        [self.titleLabel, self.authorLabel].forEach { (subview: UILabel) in
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.authorLabel.topAnchor.constraint(equalTo: self.titleLabel.layoutMarginsGuide.bottomAnchor),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
