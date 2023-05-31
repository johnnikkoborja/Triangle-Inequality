//
//  UITextView.swift
//  Triangle Inequality
//
//  Created by John Nikko Borja on 9/12/22.
//

import Foundation
import UIKit

extension UITextView {
    
    // MARK: Keyboard toolbar
    func addButtonToolbar(onDone: (target: Any, action: Selector)? = nil) {
            let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

            let toolbar: UIToolbar = UIToolbar()
            toolbar.barStyle = .default
            toolbar.items = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
                UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
            ]
            toolbar.sizeToFit()

            self.inputAccessoryView = toolbar
        }
    
    // Default toolbar actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}
