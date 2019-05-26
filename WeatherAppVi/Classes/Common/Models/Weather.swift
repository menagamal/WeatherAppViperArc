//
//  Weather.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation

class Weather :BaseModel  {
    
    var weatherDescription:String!
    
    var icon:String!
    
    var windsSpeed:String!
    
    var clouds:String!
    
    var temp:String!
   
    var city = City()

    
    override init(json:[String:Any]) {
        
        city = City(json: json)
        
        let weatherJson = (json["weather"] as! [[String:Any]]).first!
        weatherDescription = weatherJson["description"] as? String ?? ""
        icon = weatherJson["icon"] as? String ?? ""
        
        if let windsJson = json["wind"] as? [String:Any] {
            windsSpeed = String(windsJson["speed"] as! Double)
        }
        
        if let cloudsJson = json["clouds"] as? [String:Any] {
            clouds = String(cloudsJson["all"] as! Int)
        }
        
        if let mainJson = json["main"] as? [String:Any] {
            temp = String(mainJson["temp"] as! Double)
        }
        
        super.init(json: weatherJson)
        
    }
 
    
    
    
}
