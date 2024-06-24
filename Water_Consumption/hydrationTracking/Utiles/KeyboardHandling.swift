//
//  KeyboardHandling.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 24/06/24.
//

import Foundation
import UIKit

class KeyboardHandling: UIViewController, UITextFieldDelegate {
    
    var keyboardHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHandling()
    }
    
    func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        keyboardHeight = keyboardFrame.cgRectValue.height
        
        animateViewForShowingKeyboard()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        animateViewForHidingKeyboard()
    }
    
    func animateViewForShowingKeyboard() {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -self.keyboardHeight + self.view.safeAreaInsets.bottom)
        }
    }
    
    func animateViewForHidingKeyboard() {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // UITextFieldDelegate method to handle return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
