//
//  Facility+CoreDataClass.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 4/22/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import Foundation
import CoreData

@objc(Facility)
public class Facility: NSManagedObject {
    
    var inspectionArray: [Inspection]? {
        return self.inpsections?.allObjects as? [Inspection]
    }
    

    convenience init?(address: String, name: String, type: String, license: Int, risk: Decimal, latitude: Double, longitude: Double, favorited: Bool) {
        guard let context = Model.sharedInstance.managedContext else { return nil }
        
        self.init(entity: Facility.entity(), insertInto: context)
        
        self.address = address
        self.name = name
        self.type = type
        self.license = Int32(license)
        self.risk = risk as NSDecimalNumber
        self.latitude = latitude
        self.longitude = longitude
        self.favorited = favorited
    }
}
