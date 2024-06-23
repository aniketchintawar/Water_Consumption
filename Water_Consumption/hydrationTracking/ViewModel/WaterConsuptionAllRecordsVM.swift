//
//  WaterConsuptionAllRecordsVM.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 23/06/24.
//

import Foundation

class WaterConsuptionAllRecordsVM: NSObject {
    private var consuptionHelper = waterConsuptionHelper()
    var utiles = Utiles()
    func getAllRecords(MemberId:String,StartDate:String,EndDate:String) -> [consuption]? {
        return consuptionHelper.SortDateWise(forMemberId: MemberId, startingDate: StartDate, endingDate: EndDate)
     
    }
    
  
    func UpdateData(cosumption:consuption) -> Bool {
        return consuptionHelper.update(Member: cosumption)
    }
}
