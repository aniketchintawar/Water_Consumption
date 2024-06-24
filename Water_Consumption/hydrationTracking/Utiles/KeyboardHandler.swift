//
//  KeyboardHandling.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 24/06/24.
//

import Foundation
import UIKit
import UIKit

@objc protocol KeyboardHandling: AnyObject {
    func setupKeyboardHandling()
    @objc func keyboardWillShow(notification: NSNotification)
    @objc func keyboardWillHide(notification: NSNotification)
    @objc func dismissKeyboard()
}

extension KeyboardHandling where Self: UIViewController {
    func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomInset = keyboardHeight - (view.safeAreaInsets.bottom)
            
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -bottomInset
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

