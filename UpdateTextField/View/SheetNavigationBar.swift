//
//  SheetNavigationBar.swift
//  Sightline
//
//  Created by YML on 02/04/23.
//

import UIKit
import YMatterType

public final class SheetNavigationBar: UINavigationBar {
    enum Constant {
        static let insets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 2, trailing: 0)
        static let cornerRadius: CGFloat = 16
    }
    
    public let navItem: UINavigationItem.NavigationItem
    public let appearance: UINavigationItem.Appearance

    public var rightButtonTapped: (() -> Void)?
    public var leftButtonTapped: (() -> Void)?

    private var rootNavigationItem: UINavigationItem? { items?.first }

    public init(
        navItem: UINavigationItem.NavigationItem,
        appearance: UINavigationItem.Appearance = UINavigationItem.Appearance()
    ) {
        self.navItem = navItem
        self.appearance = appearance
        super.init(frame: .zero)

        configure()
        configureAppearance()
    }

    required public init?(coder aDecoder: NSCoder) { nil }

    public func updateRightButton(isEnabled: Bool) {
        rootNavigationItem?.rightBarButtonItem?.isEnabled = isEnabled
    }

    public func updateLeftButton(isEnabled: Bool) {
        rootNavigationItem?.leftBarButtonItem?.isEnabled = isEnabled
    }
}

private extension SheetNavigationBar {
    func configure() {
        items = [makeNavigationItem()]
    }

    func makeNavigationItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()

        if let title = navItem.title {
            navigationItem.title = title
            titleTextAttributes = appearance.getTitleAttributes(
                additionalAttributes: [.foregroundColor: appearance.title.textColor],
                traitCollection: traitCollection
            )
        }

        navigationItem.leftBarButtonItem = makeLeftBarButton()
        navigationItem.rightBarButtonItem = makeRightBarButton()
        return navigationItem
    }

    func makeLeftBarButton() -> UIBarButtonItem? {
        guard let leftButtonTitle = navItem.leftButtonTitle else { return  nil }

        let leftButtonTitleColor = appearance.leftButtonTitle.textColor

        let leftButtonItem = UIBarButtonItem(
            title: leftButtonTitle,
            style: .plain,
            target: self,
            action: #selector(handleLeftButtonTap)
        )
        let leftButtonNormalAttributes = appearance.getleftButtonTitleAttributes(
            additionalAttributes: [.foregroundColor: leftButtonTitleColor],
            traitCollection: traitCollection
        )
        let leftButtonDisabledAttributes = appearance.getleftButtonTitleAttributes(
            additionalAttributes: [.foregroundColor: leftButtonTitleColor.withAlphaComponent(0.5)],
            traitCollection: traitCollection
        )

        leftButtonItem.setTitleTextAttributes(leftButtonNormalAttributes, for: .highlighted)
        leftButtonItem.setTitleTextAttributes(leftButtonNormalAttributes, for: .normal)
        leftButtonItem.setTitleTextAttributes(leftButtonDisabledAttributes, for: .disabled)

        return leftButtonItem
    }

    func makeRightBarButton() -> UIBarButtonItem? {
        guard let rightButtonTitle = navItem.rightButtonTitle else { return nil }
        let rightButtonTitleColor = appearance.rightButtonTitle.textColor

        let rightButtonItem = UIBarButtonItem(
            title: rightButtonTitle,
            style: .plain,
            target: self,
            action: #selector(handleRightButtonTap)
        )

        let rightButtonNormalAttributes = appearance.getRightButtonTitleAttributes(
            additionalAttributes: [.foregroundColor: rightButtonTitleColor],
            traitCollection: traitCollection
        )
        let rightButtonDisabledAttributes = appearance.getRightButtonTitleAttributes(
            additionalAttributes: [.foregroundColor: rightButtonTitleColor.withAlphaComponent(0.5)],
            traitCollection: traitCollection
        )

        rightButtonItem.setTitleTextAttributes(rightButtonNormalAttributes, for: .highlighted)
        rightButtonItem.setTitleTextAttributes(rightButtonNormalAttributes, for: .normal)
        rightButtonItem.setTitleTextAttributes(rightButtonDisabledAttributes, for: .disabled)

        return rightButtonItem
    }

    func configureAppearance() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.shadowColor = .clear
        barAppearance.backgroundColor =  .white

        scrollEdgeAppearance = barAppearance
        standardAppearance = barAppearance
    }

    @objc func handleLeftButtonTap() {
        leftButtonTapped?()
    }

    @objc func handleRightButtonTap() {
        rightButtonTapped?()
    }
}
