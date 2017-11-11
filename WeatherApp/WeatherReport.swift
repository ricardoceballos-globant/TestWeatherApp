//
//  WeatherReport.swift
//  WeatherApp
//
//  Created by Ricardo Ceballos Peña on 11/10/17.
//  Copyright © 2017 globant. All rights reserved.
//

import UIKit

class WeatherReport: NSObject {
    
    var lon:Double?
    var lat:Double?
    var weatherMain:String?
    var weatherDescription:String?
    var temp:Double?
    var pressure:Double?
    var humidity:Double?
    var tempMin:Double?
    var tempMax:Double?
    var seaLevel:Double?
    var windSpeed:Double?
    var windDeg:Double?
    var sunrise:Double?
    var sunset:Double?
    var name:String?

    override init() {
        
    }
    
    init?(_ jsonObject: Any) {
        
        if let dictionary = jsonObject as? [String: Any] {
            
            if let coord = dictionary["coord"] as? [String: Any] {
                self.lon = coord["lon"] as?  Double
                self.lat = coord["lat"] as? Double
            }
            
            if let weather = dictionary["weather"] as? [String: String] {
                self.weatherMain = weather["main"]
                self.weatherDescription = weather["description"] 
            }
            
            if let base = dictionary["base"] as? [String] {
                // access individual value in dictionary
            }
            
            if let main = dictionary["main"] as? [String: Any] {
                self.temp = main["temp"] as?  Double
                self.pressure = main["pressure"] as? Double
                self.humidity = main["humidity"] as?  Double
                self.tempMin = main["temp_min"] as? Double
                self.tempMax = main["temp_max"] as?  Double
                self.seaLevel = main["sea_level"] as? Double
            }
            
            if let wind = dictionary["wind"] as? [String: Any] {
                self.windSpeed = wind["speed"] as? Double
                self.windDeg = wind["deg"] as?  Double
            }
            
            if let clouds = dictionary["clouds"] as? [String: Any] {
                // access individual value in dictionary
            }
            
            if let dt = dictionary["dt"] as? Int {
                // access individual value in dictionary
            }
            
            if let sys = dictionary["sys"] as? [String: Any] {
                self.sunrise = sys["sunrise"] as? Double
                self.sunset = sys["sunset"] as?  Double
            }
            
            if let id = dictionary["id"] as? Int {
                // access individual value in dictionary
            }
            
            if let name = dictionary["name"] as? String {
                // access individual value in dictionary
                self.name = name
            }
            
            if let cod = dictionary["cod"] as? [String: Any] {
                // access individual value in dictionary
            }
            
            for (key, value) in dictionary {
                // access all key / value pairs in dictionary
            }
            
            if let nestedDictionary = dictionary["anotherKey"] as? [String: Any] {
                // access nested dictionary values by key
            }
        }
        
    }
}
