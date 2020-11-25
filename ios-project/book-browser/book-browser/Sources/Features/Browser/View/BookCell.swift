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
            self.contentView.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            self.coverView.widthAnchor.constraint(equalToConstant: Layout.coverViewSide),
            self.coverView.heightAnchor.constraint(equalToConstant: Layout.coverViewSide),
            self.coverView.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor),
            self.coverView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.coverView.layoutMarginsGuide.trailingAnchor, multiplier: 2.0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.authorLabel.topAnchor.constraint(equalTo: self.titleLabel.layoutMarginsGuide.bottomAnchor, constant: Layout.authorLabelTopInset),
            self.authorLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.coverView.layoutMarginsGuide.trailingAnchor, multiplier: 2.0),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = nil
        self.authorLabel.text = nil
        self.coverView.image = nil
    }
}

/// Private type wrapping appearance constants
private enum Layout {
    
    static let authorLabelTopInset: CGFloat = 8.0
    static let coverViewSide: CGFloat = 44.0
}
