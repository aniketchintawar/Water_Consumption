//
//  SignUpVM.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 23/06/24.
//

import Foundation

class SignUpVM: NSObject {
    var objMemberLogin = membeLoginData()
    
    func signUpDetails(fullName:String, password:String, mobileNumber:String,email:String,memberId:String){
        var member = member(memberId: memberId , fullName: fullName, email: email, mobileNo: mobileNumber, password: password)
        objMemberLogin.create(Member: member)
        
    }

}
