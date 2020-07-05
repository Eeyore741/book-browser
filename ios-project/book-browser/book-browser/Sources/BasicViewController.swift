//
//  BasicViewController.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 05/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

final class BasicViewController: UIViewController {
    
    private let v: UIView
    
    init(view: UIView) {
        self.v = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.v
    }
}
