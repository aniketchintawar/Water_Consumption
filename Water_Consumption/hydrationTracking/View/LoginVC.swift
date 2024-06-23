//
//  ViewController.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 17/06/24.
//

import UIKit

class LoginVC: UIViewController {
   

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtMemberId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var loginVM = LoginVM()
    @IBOutlet weak var btnForget: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        debugPrint("Data base url \(getDocumentsDirectory())")
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    @IBAction func loginButton(_ sender: Any) {
        btnLogin.isEnabled = false
        guard let memberId = txtMemberId.text,!memberId.isEmpty  else {
                self.showAlert(title: "Empty Field", message: "Please Enter Member Id.")
                
            btnLogin.isEnabled = true
            return
        }
        guard let password = txtPassword.text,!password.isEmpty else {
            self.showAlert(title: "Empty Field", message: "Please Enter password")
            btnLogin.isEnabled = true
            return
        }
       var isSuccess = loginVM.checkLoginDetails(UserName: memberId, Password: password)
        if isSuccess{
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(txtMemberId.text, forKey: "MemberId")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let indexViewController = storyboard.instantiateViewController(withIdentifier: "indexVC") as? indexVC {
                        
                        self.navigationController?.pushViewController(indexViewController, animated: true)
                    }
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                        if granted {
                            print("Notification authorization granted")
                            
                            // Schedule notifications
                            self.scheduleHalfHourlyNotifications()
                        } else {
                            print("Notification authorization denied")
                        }
                    }
            btnLogin.isEnabled = true
        }else{
            
            self.showAlert(title: "Login Failed", message: "Please Enter Valid Login Details")
            btnLogin.isEnabled = true
        }
    }
    
    @IBAction func forgotButton(_ sender: Any) {
        btnForget.isEnabled = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordVC {
                    
                    self.navigationController?.pushViewController(detailViewController, animated: true)
                }
        btnForget.isEnabled = true
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        btnSignUp.isEnabled = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC {
                    self.navigationController?.pushViewController(detailViewController, animated: true)
                }
        btnSignUp.isEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        txtMemberId.text = ""
        txtPassword.text = ""
       
    }
    func scheduleHalfHourlyNotifications() {
            let center = UNUserNotificationCenter.current()
            
            // Remove all previously scheduled notifications
            center.removeAllPendingNotificationRequests()
            
            // Create notification content
            let content = UNMutableNotificationContent()
            content.title = "Drink Water Reminder"
            content.body = "Time to hydrate! Check your water consumption."
            content.sound = .default
            
            // Configure notification trigger for every half hour
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true) //1800
            
            // Create a notification request
            let request = UNNotificationRequest(identifier: "halfHourlyNotification", content: content, trigger: trigger)
            
            // Add the notification request to the notification center
            center.add(request) { (error) in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        }
}


