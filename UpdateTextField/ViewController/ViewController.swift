//
//  ViewController.swift
//  UpdateTextField
//
//  Created by Karthik K Manoj on 21/04/23.
//

import UIKit
import YCoreUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.setTitle("Tap here", for: .normal)
        button.addTarget(self, action: #selector(handleDidTap), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.constrainCenter()
    }
    
    @objc func handleDidTap() {
        let bottomSheet =  UpdateTextUIComposer.makeUpdateTextBottomSheet(title: "Hello", textField: UITextField(), didSelectRightButton: { _ in})
        present(bottomSheet, animated: true)
    }


}

