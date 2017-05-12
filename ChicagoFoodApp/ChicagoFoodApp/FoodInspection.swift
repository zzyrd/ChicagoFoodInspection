//
//  FoodInspection.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 4/23/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import Foundation

struct FoodInspection {
    var type: String
    var result: String
    var violation: String
    var id : Int
    var date: Date
    
    init(type: String, result: String, violation: String, id: Int, date: Date) {
        self.type = type
        self.result = result
        self.violation = violation
        self.id = id
        self.date = date
        
    }
    
    
    
    
}
