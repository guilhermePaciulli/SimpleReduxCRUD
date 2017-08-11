//
//  Extensions.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 07/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import UIKit


extension String {
    public func isValid() -> Bool {
        return !(self.isEmpty || self.trimmingCharacters(in: .whitespaces).isEmpty)
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
