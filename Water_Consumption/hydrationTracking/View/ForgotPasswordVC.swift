//
//  ForgotPasswordVC.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 18/06/24.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var btnforget: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtconformPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var memberId: UITextField!
    var forgetPasswordVM = ForgetPasswordVM()
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    

    @IBAction func forgetButton(_ sender: Any) {
        btnforget.isEnabled = false
        guard let memberId = memberId.text,!memberId.isEmpty  else {
            self.showAlert(title: "Empty Field", message: "Please Enter Member Id.")
            return
        }
        guard let password = txtPassword.text,!password.isEmpty else {
            self.showAlert(title: "Empty Field", message: "Please Enter password.")
            return
        }
        let result =  forgetPasswordVM.updateLoginDetails(memberId: memberId, password: password)
        if result{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                btnforget.isEnabled = true

                        self.navigationController?.pushViewController(LoginViewController, animated: true)
                    }
        }else
        {
            self.showAlert(title: "Error", message: "Failed To Update Password Password.")
            btnforget.isEnabled = true

        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        btnLogin.isEnabled = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                    
                    self.navigationController?.pushViewController(LoginViewController, animated: true)
                }
        btnLogin.isEnabled = true
    }
    
}
