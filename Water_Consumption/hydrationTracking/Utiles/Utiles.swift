//
//  Utiles.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 23/06/24.
//

import Foundation
import UIKit
class Utiles: NSObject {
    let userDefaults = UserDefaults.standard
    func SaveValueInUserDefault(value:String, key:String){
        userDefaults.setValue(value, forKey: key)
    }
    func GetValueInUserDefault(key:String) -> String
    {
        return userDefaults.object(forKey:"MemberId") as! String
    }
}
extension UIViewController{
    func showAlert(title : String , message :String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
}
