//
//  InputView.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 05/07/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import UIKit

final class InputView: UIView {
    
    override class var requiresConstraintBasedLayout: Bool { true }
    
    public var viewModel: InputViewModel
    
    private let textField = UITextField(frame: CGRect.zero)
    
    private var subviewsLayoutOnce: Bool = false
    private var constraintsLayoutOnce: Bool = false
    
    init(viewModel: InputViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        if self.subviewsLayoutOnce == false {
            self.subviewsLayoutOnce = true
            self.backgroundColor = self.viewModel.backgroundColor()
            
            self.textField.textColor = self.viewModel.textColor()
            self.textField.borderStyle = UITextField.BorderStyle.roundedRect
            self.textField.clearButtonMode = UITextField.ViewMode.always
            self.textField.backgroundColor = self.viewModel.textBackgroundColor()
            self.textField.returnKeyType = UIReturnKeyType.done
            self.textField.addTarget(self, action: #selector(InputView.onTextEditDone), for: UIControl.Event.editingDidEndOnExit)
            self.addSubview(textField)
            
            self.setNeedsUpdateConstraints()
            self.updateConstraintsIfNeeded()
        }
        super.layoutSubviews()
    }
    
    override func updateConstraints() {
        if self.subviewsLayoutOnce == true, self.constraintsLayoutOnce == false {
            self.constraintsLayoutOnce = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.widthAnchor.constraint(equalToConstant: Layout.editWidthAnchorConst),
                textField.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.editTopAnchorConst),
                textField.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }
        super.updateConstraints()
    }
    
    @objc public func onTextEditDone(_ sender: Any) {
        self.viewModel.onTextViewDone(self.textField.text)
    }
}

private enum Layout {
    
    static var editTopAnchorConst: CGFloat = { UIScreen.main.bounds.height / 4.0 }()
    static var editWidthAnchorConst: CGFloat = { UIScreen.main.bounds.width / 2.0 }()
}

extension InputView: UILoadable {
    
    func didLoad() {
        assertionFailure("Undefined")
    }
}
