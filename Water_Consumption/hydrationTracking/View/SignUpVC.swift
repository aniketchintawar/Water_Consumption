//
//  SignUpVC.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 18/06/24.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    var memberId: String = ""
    var signUp = SignUpVM()
    override func viewDidLoad() {
        super.viewDidLoad()
    memberId = String(generateFiveDigitRandomNumber())

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        clearAllTextField()
    }
    

    @IBAction func signUpButton(_ sender: Any) {
        btnSignUp.isEnabled = false
        guard let fullName = txtFullName.text,!fullName.isEmpty  else {
                self.showAlert(title: "Empty Field", message: "Please Enter Name.")
                
            
            return
        }
        guard let password = txtpassword.text,!password.isEmpty else {
            self.showAlert(title: "Empty Field", message: "Please Enter Password")
            return
        }
        guard let mobileNo = txtMobileNo.text,!mobileNo.isEmpty  else {
            self.showAlert(title: "Empty Field", message: "Please Enter Mobile Number.")
            
            return
        }
        guard let email = txtEmail.text,!email.isEmpty else {
            self.showAlert(title: "Empty Field", message: "Please Enter Email")
            return
        }
        signUp.signUpDetails(fullName: fullName, password: password, mobileNumber: mobileNo, email: email, memberId: memberId)
        showAlert(title: "Member Id", message: "Use member Id As UserName : \(memberId)")
        btnSignUp.isEnabled = true
        clearAllTextField()
    }
    
    func generateFiveDigitRandomNumber() -> Int {
        return Int.random(in: 10000...99999)
    }
    func clearAllTextField() {
        txtFullName.text = ""
        txtpassword.text = ""
        txtMobileNo.text = ""
        txtEmail.text = ""
    }
}
