//
//  LoginDetails+CoreDataProperties.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 23/06/24.
//
//

import Foundation
import CoreData


extension LoginDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginDetails> {
        return NSFetchRequest<LoginDetails>(entityName: "LoginDetails")
    }

    @NSManaged public var email: String?
    @NSManaged public var fullName: String?
    @NSManaged public var memberId: String?
    @NSManaged public var mobileNo: String?
    @NSManaged public var password: String?

}

extension LoginDetails : Identifiable {
    func ConvertToMember() -> member {
               return member(memberId: self.memberId!, fullName: self.fullName ?? "", email: self.email ?? "", mobileNo: self.mobileNo ?? "", password: self.password ?? "")
           }
}

