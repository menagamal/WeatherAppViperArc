//
//  City.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation

class City:BaseModel {
    
    var lat:Double!
    var lng:Double!
    
    override init() {
        super.init()
    }
    override init(json:[String:Any]) {
        
        super.init(json: json)
        if let cordinateJson = json["coord"] as? [String:Any] {
            
            lat = cordinateJson["lat"] as! Double
            lng = cordinateJson["lon"] as! Double
            
        }
        
    }
    
    
}
