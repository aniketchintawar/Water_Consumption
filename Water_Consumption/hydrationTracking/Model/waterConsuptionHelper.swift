//
//  waterConsuptionHelper.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 19/06/24.
//

import Foundation
import CoreData

protocol consuptionData{
    func create(Member:consuption)
    func get(byIdentifirer memberId: String) -> consuption?
    func update(Member:consuption)-> Bool
    
}

struct waterConsuptionHelper : consuptionData
{
    func create(Member: consuption) {
        let CDMember = MemberWaterCousuptionDetails(context: PersistentStorage.shared.context)
        CDMember.date = Member.date
        CDMember.litre = Member.litre
        CDMember.time = Member.time
        CDMember.memberId = Member.memberId
        CDMember.waterConsuptionCount = Member.waterConsuptionCount
        PersistentStorage.shared.saveContext()
    }
    
    func getAll(forMemberId memberId: String) -> [consuption]? {
        let fetchRequest = NSFetchRequest<MemberWaterCousuptionDetails>(entityName: "MemberWaterCousuptionDetails")
        let predicate = NSPredicate(format: "memberId == %@", memberId as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest)
            
            var employee: [consuption] = []
            result.forEach { cdemployee in
                employee.append(cdemployee.ConvertToWaterConsuption())
            }
            return employee
        } catch let error {
            debugPrint("Failed to fetch data:", error.localizedDescription)
            return nil
        }
    }
    
    func get(byIdentifirer memberId: String) -> consuption? {
        let result = getcdMember(byidentifier: memberId)
        
        guard result != nil else{
            return nil
        }
        return result?.ConvertToWaterConsuption()
    }
    
    func update(Member: consuption)-> Bool {
        let result = getDataAsDateWise(byidentifier: Member.memberId, date: Member.date, time: Member.time)
        
        guard result != nil else{ return false}
        result?.litre = Member.litre
        PersistentStorage.shared.saveContext()
        return true
    }
    func updateDateWise(Member: consuption) -> Bool {
        // Fetch the specific record
        guard let recordToUpdate = getDataAsDateWise(byidentifier: Member.memberId, date: Member.date, time: Member.time) else {
            return false
        }
        // Update the record
        recordToUpdate.litre = Member.litre
        // Save the context
        PersistentStorage.shared.saveContext()
        
        return true
    }
    func SortDateWise(forMemberId memberId: String, startingDate: String, endingDate: String) -> [consuption]? {
        let fetchRequest = NSFetchRequest<MemberWaterCousuptionDetails>(entityName: "MemberWaterCousuptionDetails")
        
        // Create predicates
        let memberIdPredicate = NSPredicate(format: "memberId == %@", memberId as CVarArg)
        let datePredicate = NSPredicate(format: "date >= %@ AND date <= %@", startingDate as CVarArg, endingDate as CVarArg)
        
        // Combine predicates
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [memberIdPredicate, datePredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest)
            
            var consumptions: [consuption] = []
            result.forEach { cdemployee in
                consumptions.append(cdemployee.ConvertToWaterConsuption())
            }
            
            return consumptions
        } catch let error {
            debugPrint("Failed to fetch data:", error.localizedDescription)
            return nil
        }
    }
    
    
    func getcdMember(byidentifier memberId: String) -> MemberWaterCousuptionDetails? {
        let fetchRequest = NSFetchRequest<MemberWaterCousuptionDetails>(entityName: "MemberWaterCousuptionDetails")
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
    
    func getDataAsDateWise(byidentifier memberId: String,date: String, time: String) -> MemberWaterCousuptionDetails? {
        let fetchRequest = NSFetchRequest<MemberWaterCousuptionDetails>(entityName: "MemberWaterCousuptionDetails")
        
        // Create predicates
        let memberIdPredicate = NSPredicate(format: "memberId == %@", memberId as CVarArg)
        let datePredicate = NSPredicate(format: "date == %@", date as CVarArg)
        let timePredicate = NSPredicate(format: "time == %@", time as CVarArg)
        
        // Combine predicates
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [memberIdPredicate, datePredicate, timePredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            return result
        } catch let error {
            debugPrint("Failed to fetch data:", error.localizedDescription)
            return nil
        }
    }
}
