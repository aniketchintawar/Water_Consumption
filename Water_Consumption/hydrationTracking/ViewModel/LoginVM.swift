//
//  LoginVM.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 23/06/24.
//

import Foundation

class LoginVM: NSObject {
    var objMemberLogin = membeLoginData()
    var utiles = Utiles()
    func checkLoginDetails(UserName : String, Password : String) -> Bool {
        var isSuccess = objMemberLogin.isMemberValid(byIdentifier: UserName, password: Password)
        if isSuccess{
            utiles.SaveValueInUserDefault(value: UserName, key: "MemberId")
        }
        return isSuccess
    }
    
}
