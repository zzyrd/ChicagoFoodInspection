//
//  JSONLoader.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 4/23/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import Foundation

class JSONLoader {
    
    class func load(fileName: String) -> [FoodFacility] {
        var foodfacilities = [FoodFacility]()
        if let path = Bundle.main.path(forResource: fileName, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            
            foodfacilities = JSONParser.parse(data)
        }
        return foodfacilities
    }
}
