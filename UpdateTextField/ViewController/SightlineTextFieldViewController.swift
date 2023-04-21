//
//  SightlineTextFieldViewController.swift
//  Sightline
//
//  Created by YML on 31/03/23.
//

import YCoreUI
import YMatterType
import UIKit
import Foundation

final class SightlineTextFieldViewController: UIViewController {
    enum Constant {
        static let textFieldInsets = NSDirectionalEdgeInsets(
            top: SheetNavigationBar.Constant.insets.bottom + 14,
            leading: 24,
            bottom: 40,
            trailing: 24
        )

        static let cornerRadius: CGFloat = 16
    }

    var text: String? {
        sightlineTextField.text
    }
    
    let navigationBar: SheetNavigationBar
    let sightlineTextField: UITextField

    private var bottomConstraint: NSLayoutConstraint?

    init(textField: UITextField, navigationBar: SheetNavigationBar) {
        self.sightlineTextField = textField
        self.navigationBar = navigationBar
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
        configure()
        registerKeyboardNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        sightlineTextField.becomeFirstResponder()
    }

    @objc func editingChanged(_ textField: TypographyTextField) {
        navigationBar.updateRightButton(isEnabled: !textField.text.isEmpty)
    }
}

private extension SightlineTextFieldViewController {
    func build() {
        buildViews()
        buildConstraints()
    }

    func buildViews() {
        view.addSubview(navigationBar)
        view.addSubview(sightlineTextField)
    }

    func buildConstraints() {
        navigationBar.constrainEdges(.top, with: SheetNavigationBar.Constant.insets)
        navigationBar.constrainEdges(.horizontal)

        sightlineTextField.constrain(.topAnchor, to: navigationBar.bottomAnchor, constant: Constant.textFieldInsets.top)
        sightlineTextField.constrainEdges(.horizontal, with: Constant.textFieldInsets)
        bottomConstraint = sightlineTextField.constrain(
            .bottomAnchor,
            to: view.bottomAnchor,
            constant: -Constant.textFieldInsets.bottom
        )
    }

    func configure() {
        view.layer.cornerRadius = Constant.cornerRadius
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        
        sightlineTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
}

private extension SightlineTextFieldViewController {
    func registerKeyboardNotifications() {
        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        bottomConstraint?.constant = -keyboardValue.cgRectValue.height
    }

    @objc func keyboardWillHide() {
        bottomConstraint?.constant = -Constant.textFieldInsets.bottom
    }
}
