//
//  Model.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 4/23/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import UIKit
import CoreData

class Model {
    // MARK: - Properties
    var managedContext: NSManagedObjectContext?
    
    // MARK: Static
    static var sharedInstance: Model = Model()
    
    // MARK: - Initializer
    init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let persistentContainer = appDelegate?.persistentContainer
        managedContext = persistentContainer?.viewContext
    }
    
    // MARK: - Core Data Functions
    func loadData() {
        let coreDataLoadedKey = "hasLoadedCoreData"
        guard !UserDefaults.standard.bool(forKey: coreDataLoadedKey) else { return }

        let chicagoRests = JSONLoader.load(fileName: "test")
        //print(chicagoRests.count)
        
        for chicagoRest in chicagoRests {
            
            if let facility = Facility(address: chicagoRest.address, name: chicagoRest.name, type: chicagoRest.type, license: chicagoRest.license, risk: chicagoRest.risk, latitude: chicagoRest.latitude, longitude: chicagoRest.longitude, favorited: chicagoRest.favorited) {
                for inspection in chicagoRest.inspections {
                            if let eachInspection = Inspection(type: inspection.type, result: inspection.result, violation: inspection.violation, id: inspection.id, date: inspection.date) {
                                facility.addToInpsections(eachInspection)
                                
                            }
                        }
                    }
                }
        
                do {
                    try self.managedContext?.save()
        
                    UserDefaults.standard.set(true, forKey: coreDataLoadedKey)
                } catch {
                    return
                }
    }
    
    func fetchFacilities() -> [Facility] {
        do {
            let array = try managedContext?.fetch(Facility.fetchRequest()) ?? []
            return array
        } catch {
            return []
        }
    }
    
    
}
