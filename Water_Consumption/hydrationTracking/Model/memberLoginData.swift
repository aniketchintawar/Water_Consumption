//
//  memberLoginData.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 18/06/24.
//

import Foundation
import CoreData

protocol memberData{
    func create(Member:member)
    func getAll() ->[member]?
    func get(byIdentifirer memberId: String) -> member?
    func update(Member:member)-> Bool
    
}

struct membeLoginData : memberData
{
    func create(Member: member) {
        let CDMember = LoginDetails(context: PersistentStorage.shared.context)
        CDMember.email = Member.email
        CDMember.fullName = Member.fullName
        CDMember.memberId = Member.memberId
        CDMember.mobileNo = Member.mobileNo
        CDMember.password = Member.password
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [member]? {
        let result = PersistentStorage.shared.FetchMember(manageObject: LoginDetails.self)
        
        var employee : [member] = []
        result?.forEach({ (cdemployee) in
            
            employee.append(cdemployee.ConvertToMember())
                })
        return employee
    }
    
    func get(byIdentifirer memberId: String) -> member? {
        let result = getcdMember(byidentifier: memberId)
        
        guard result != nil else{
            return nil
        }
       return result?.ConvertToMember()
    }
    
    func update(Member: member)-> Bool {
        let result = getcdMember(byidentifier: Member.memberId)
        
        guard result != nil else{ return false}
        result?.password = Member.password
        PersistentStorage.shared.saveContext()
        return true
    }
    
    
    func getcdMember(byidentifier memberId: String) -> LoginDetails? {
        let fetchRequest = NSFetchRequest<LoginDetails>(entityName: "LoginDetails")
        let predicate = NSPredicate(format: "memberId==%@", memberId as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else{
                return nil
            }
           return result
        }catch let error{
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    func isMemberValid(byIdentifier memberId: String, password: String) -> Bool {
        let fetchRequest = NSFetchRequest<LoginDetails>(entityName: "LoginDetails")
        
        // Create predicates for memberId and password
        let memberIdPredicate = NSPredicate(format: "memberId == %@", memberId as CVarArg)
        let passwordPredicate = NSPredicate(format: "password == %@", password)
        
        // Combine the predicates
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [memberIdPredicate, passwordPredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            // Return true if a result is found, otherwise false
            return result != nil
        } catch let error {
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
    
}
