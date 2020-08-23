//
//  KeyboardExtension.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-17.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
