//
//  JSONParser.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 4/23/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import Foundation

class JSONParser {
    
    static let dateFormatter = DateFormatter()

    
    class func parse(_ data: Data) -> [FoodFacility] {
        var foodfacilities = [FoodFacility]()
      
        if let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let root = json as? [String: Any],
            let dataNodes = root["data"] as? [[Any]]
        {
            for dataNode in dataNodes{
                        //parse facility
                        let address = dataNode[14] as? String ?? ""
                        let name = dataNode[9] as? String ?? ""
                        let type = dataNode[12] as? String ?? ""
                        let li = dataNode[11] as? String ?? ""
                        let license = Int(li) ?? -1
                        let riskvalue = dataNode[13] as? String ?? ""
                        let la = dataNode[22] as? String ?? ""
                        let latitude = Double(la) ?? 0.0
                        let lo = dataNode[23] as? String ?? ""
                        let longitude = Double(lo) ?? 0.0
                        //manually check risk value
                        let risk: Decimal
                        if riskvalue == "Risk 1 (High)" {
                            risk = 1
                        }
                        else if riskvalue == "Risk 2 (Medium)" {
                            risk = 2
                        }
                        else if riskvalue == "Risk 3 (Low)" {
                            risk = 3
                        }
                        else{
                            risk = 0
                        }
                    
                        var newFacility: FoodFacility
                        //get the facility by name if there is one stored in foodfacilities
                        let facilityChecking = foodfacilities.first(where: { (element) -> Bool in
                            return element.name == name
                            
                        })
                        if facilityChecking == nil {
                            newFacility = FoodFacility(address: address, name: name, type: type, license: license, risk: risk, latitude: latitude, longitude: longitude, favorited: false)
                        }
                        else{//force unwrap the facilityChecking because it is not nil
                            newFacility = facilityChecking!
                        }
                        //parse inspection
                        let inspectID = dataNode[8] as? String ?? ""
                        let id = Int(inspectID) ?? -1
                        let dateStr = dataNode[18] as? String ?? ""
                        let inspectType = dataNode[19] as? String ?? ""
                        let result = dataNode[20] as? String ?? ""
                        let violation = dataNode[21] as? String ?? ""
                        //get date, month, and year from dateStr
                        let str_index = dateStr.index(dateStr.startIndex, offsetBy: 10)
                        let realDate = dateStr.substring(to: str_index)
                        dateFormatter.dateFormat = "yyyy/MM/dd"
                        let storedDate = dateFormatter.date(from: realDate)
                        if let date = storedDate {
                                newFacility.inspections.append(FoodInspection(type: inspectType, result: result, violation: violation, id: id, date: date))
                        }
                
                        //when not find any facility in foodfacilities by name, then add new facility to the list
                        if facilityChecking == nil {
                            foodfacilities.append(newFacility)
                        }
                        else{
                            
                            if let index = foodfacilities.index(where: { (element) -> Bool in
                                return element.name == newFacility.name
                            }) {
                                foodfacilities[index] = newFacility
                            }
                        }
                
            }
            
        }
        print("Task is done !")
        return foodfacilities
    }
}
