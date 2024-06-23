//
//  MemberWaterCousuptionDetails+CoreDataProperties.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 23/06/24.
//
//

import Foundation
import CoreData


extension MemberWaterCousuptionDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemberWaterCousuptionDetails> {
        return NSFetchRequest<MemberWaterCousuptionDetails>(entityName: "MemberWaterCousuptionDetails")
    }

    @NSManaged public var date: String?
    @NSManaged public var memberId: String?
    @NSManaged public var waterConsuptionCount: String?
    @NSManaged public var litre: String?
    @NSManaged public var time: String?

}

extension MemberWaterCousuptionDetails : Identifiable {
    func ConvertToWaterConsuption() -> consuption {
        return consuption(date: self.date ?? "", litre: self.litre ?? "", memberId: self.memberId ?? "", time: self.time ?? "", waterConsuptionCount: self.waterConsuptionCount ?? "")
    }
}


