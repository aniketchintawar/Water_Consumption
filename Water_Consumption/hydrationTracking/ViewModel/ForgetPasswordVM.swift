//
//  ForgetPasswordVM.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 23/06/24.
//

import Foundation

class ForgetPasswordVM: NSObject {
    var objMemberLogin = membeLoginData()
    func updateLoginDetails(memberId:String ,password :String) -> Bool {
        var member = member(memberId: memberId, fullName: "", email: "", mobileNo: "", password:password )
       var result =  objMemberLogin.update(Member: member)
        return result
    }
}
