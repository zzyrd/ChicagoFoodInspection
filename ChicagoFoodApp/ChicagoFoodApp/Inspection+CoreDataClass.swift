//
//  Inspection+CoreDataClass.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 4/22/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import Foundation
import CoreData

@objc(Inspection)
public class Inspection: NSManagedObject {

    
    convenience init?(type: String, result: String, violation: String, id: Int, date: Date) {
        guard let context = Model.sharedInstance.managedContext else { return nil }
        
        self.init(entity: Inspection.entity(), insertInto: context)
        
        self.type = type
        self.results = result
        self.violation = violation
        self.id = Int32(id)
        self.date = date as NSDate
        
    }

}
