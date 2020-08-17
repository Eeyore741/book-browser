//
//  GenericViewController.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 05/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

final class GenericViewController<View: UIView>: UIViewController {
    
    let rootView: View
    
    init(rootView: View) {
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = self.rootView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
