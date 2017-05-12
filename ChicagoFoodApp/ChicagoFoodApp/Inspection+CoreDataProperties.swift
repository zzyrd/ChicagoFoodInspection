//
//  Inspection+CoreDataProperties.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 4/24/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import Foundation
import CoreData


extension Inspection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Inspection> {
        return NSFetchRequest<Inspection>(entityName: "Inspection")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var results: String?
    @NSManaged public var type: String?
    @NSManaged public var violation: String?
    @NSManaged public var facilities: Facility?

}
