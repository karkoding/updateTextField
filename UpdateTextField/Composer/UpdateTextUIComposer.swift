//
//  UpdateTextUIComposer.swift
//  Sightline
//
//  Created by YML on 01/04/23.
//

import UIKit
import YBottomSheet

public final class UpdateTextUIComposer {
    static func makeSightlineTextFieldViewController(
        title: String,
        textField: UITextField,
        didSelectRightButton: @escaping (String) -> Void
    ) -> SightlineTextFieldViewController {
        let navigationBar = makeSheetNavigationBar(title: title)

        let textFieldViewController = SightlineTextFieldViewController(
            textField: textField,
            navigationBar: navigationBar
        )

        navigationBar.leftButtonTapped = { [weak textFieldViewController] in
            textFieldViewController?.dismiss(animated: true)
        }

        navigationBar.rightButtonTapped = { [weak textFieldViewController] in
            guard let textFieldViewController,
                  let text = textFieldViewController.text else { return }

            didSelectRightButton(text)
            textFieldViewController.dismiss(animated: true)
        }

        return textFieldViewController
    }

    static func makeSheetNavigationBar(title: String) -> SheetNavigationBar {
        let navigationItem = UINavigationItem.NavigationItem(
            title: title,
            leftButtonTitle: "Cancel",
            rightButtonTitle: "Save"
        )

        let navigationBar = SheetNavigationBar(navItem: navigationItem)
        navigationBar.updateRightButton(isEnabled: false)

        return navigationBar
    }

    static func makeUpdateTextBottomSheet(
        title: String,
        textField: UITextField,
        didSelectRightButton: @escaping (String) -> Void
    ) -> BottomSheetController {
        let textFieldViewController = UpdateTextUIComposer.makeSightlineTextFieldViewController(
            title: title,
            textField: textField,
            didSelectRightButton: didSelectRightButton
        )

        let sheetController = BottomSheetController(
            childController: textFieldViewController,
            appearance: BottomSheetController.Appearance(
                headerAppearance: nil,
                layout: BottomSheetController.Appearance.Layout(
                    cornerRadius: SightlineTextFieldViewController.Constant.cornerRadius
                ),
                dimmerColor: .black.withAlphaComponent(0.5)
            )
        )
        
        return sheetController
    }
}
