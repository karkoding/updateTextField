//
//  UINavigationItem+NavigationItem.swift
//  Sightline
//
//  Created by YML on 03/04/23.
//

import UIKit

extension UINavigationItem {
    public struct NavigationItem: Equatable {
        let title: String?
        let leftButtonTitle: String?
        let rightButtonTitle: String?

        public init(
            title: String? = nil,
            leftButtonTitle: String? = nil,
            rightButtonTitle: String? = nil
        ) {
            self.title = title
            self.leftButtonTitle = leftButtonTitle
            self.rightButtonTitle = rightButtonTitle
        }
    }
}
