//
//  WaterConsumptionVM.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 23/06/24.
//

import Foundation

class WaterConsumptionVM: NSObject {
    var waterConsumptionValues: [String] = []
    var utiles = Utiles()
private var consuptionHelper = waterConsuptionHelper()
    
    func saveDetails(txtTime: String?, txtWaterConsuption: String?) {
        let memberId = utiles.GetValueInUserDefault(key: "MemberId") 
            let objConsuption = consuption(date: getDateInDDMMYYYYFormat(),
                                           litre: extractDouble(from: txtWaterConsuption ?? "") ?? "",
                                           memberId: memberId,
                                           time: txtTime ?? "",
                                           waterConsuptionCount: "1")
        consuptionHelper.create(Member: objConsuption)
        }
        
        func getDateInDDMMYYYYFormat() -> String {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: currentDate)
        }
        
        func extractDouble(from string: String) -> String? {
            let pattern = "[0-9]*\\.?[0-9]+"
            
            do {
                let regex = try NSRegularExpression(pattern: pattern)
                let nsString = string as NSString
                let results = regex.matches(in: string, range: NSRange(location: 0, length: nsString.length))
                
                if let match = results.first {
                    let matchRange = match.range
                    let numberString = nsString.substring(with: matchRange)
                    return String(numberString)
                }
            } catch let error {
                print("Invalid regex: \(error.localizedDescription)")
            }
            
            return nil
        }
        
        func calculateTotalLiters(consuptionArray: [consuption]) -> Double {
            var totalLiters: Double = 0.0
            
            consuptionArray.forEach { consuption in
                totalLiters += Double(consuption.litre) ?? 0.0
            }
            
            return totalLiters
        }
    
    func getwaterConsuptionDetails() -> Double {
        var cusptionRecords = consuptionHelper.getAll(forMemberId: utiles.GetValueInUserDefault(key:"MemberId")) ?? []
        return calculateTotalLiters(consuptionArray: cusptionRecords)
    }
    
    
}
