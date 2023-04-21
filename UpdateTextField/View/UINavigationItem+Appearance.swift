//
//  UINavigationItem+Appearance.swift
//  Sightline
//
//  Created by YML on 03/04/23.
//

import UIKit
import YMatterType

extension UINavigationItem {
    /// An object to set appearance for a navigation item.
    public final class Appearance {
        public let title: (textColor: UIColor, typography: Typography)
        public let leftButtonTitle: (textColor: UIColor, typography: Typography)
        public let rightButtonTitle: (textColor: UIColor, typography: Typography)

        public init(
            title: (textColor: UIColor, typography: Typography) = (.black, .systemLabel),
            leftButtonTitle: (textColor: UIColor, typography: Typography) = (.orange, .systemLabel),
            rightButtonTitle: (textColor: UIColor, typography: Typography) = (.orange, .systemLabel)
        ) {
            self.title = title
            self.leftButtonTitle = leftButtonTitle
            self.rightButtonTitle = rightButtonTitle
        }

        func getTitleAttributes(
            additionalAttributes: [NSAttributedString.Key: Any],
            traitCollection: UITraitCollection
        ) -> [NSAttributedString.Key: Any] {
            let layout = title.typography.generateLayout(compatibleWith: traitCollection)
            return layout.buildAttributes(startingWith: additionalAttributes)
        }

        func getleftButtonTitleAttributes(
            additionalAttributes: [NSAttributedString.Key: Any],
            traitCollection: UITraitCollection
        ) -> [NSAttributedString.Key: Any] {
            let layout = leftButtonTitle.typography.generateLayout(compatibleWith: traitCollection)
            return layout.buildAttributes(startingWith: additionalAttributes)
        }

        func getRightButtonTitleAttributes(
            additionalAttributes: [NSAttributedString.Key: Any],
            traitCollection: UITraitCollection
        ) -> [NSAttributedString.Key: Any] {
            let layout = rightButtonTitle.typography.generateLayout(compatibleWith: traitCollection)
            return layout.buildAttributes(startingWith: additionalAttributes)
        }
    }
}
