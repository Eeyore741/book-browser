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
    
    private var constraintsLayoutOnce: Bool = false
    
    public let bookView: BookView = BookView()
    
    override func updateConstraints() {
        super.updateConstraints()
        
        guard self.constraintsLayoutOnce == false else { return }
        defer { self.constraintsLayoutOnce = true }
        
        self.bookView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.bookView)
        
        NSLayoutConstraint.activate([
            self.bookView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.bookView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.bookView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.bookView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        self.bookView.titleLabel.text = nil
        self.bookView.authorLabel.text = nil
        self.bookView.coverView.image = UIImage.init(named: "book")
    }
}
