//
//  FoodFacility.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 4/23/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import Foundation

struct FoodFacility {
    var address: String
    var name: String
    var type : String
    var risk: Decimal
    var latitude: Double
    var longitude: Double
    var license: Int
    var favorited: Bool
    
    var inspections: [FoodInspection]
    
    init(address: String, name: String, type: String, license: Int, risk: Decimal, latitude: Double, longitude: Double, favorited: Bool) {
        self.address = address
        self.name = name
        self.type = type
        self.license = license
        self.risk = risk
        self.latitude = latitude
        self.longitude = longitude
        self.favorited = favorited
        
        self.inspections = [FoodInspection]()
        
        
    }
    
}
