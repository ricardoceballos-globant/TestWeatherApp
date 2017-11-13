//
//  WeatherReport.swift
//  WeatherApp
//
//  Created by Ricardo Ceballos Peña on 11/10/17.
//  Copyright © 2017 globant. All rights reserved.
//

import UIKit

class WeatherReport: NSObject {
    
    var lon:Double = 0.0
    var lat:Double = 0.0
    var weatherMain:String = ""
    var weatherDescription:String = ""
    var temp:Double = 0.0
    var pressure:Double = 0.0
    var humidity:Double = 0.0
    var tempMin:Double = 0.0
    var tempMax:Double = 0.0
    var seaLevel:Double = 0.0
    var windSpeed:Double = 0.0
    var windDeg:Double = 0.0
    var sunrise:Double = 0.0
    var sunset:Double = 0.0
    var name:String = ""

    override init() {
        
    }
    
    init?(_ jsonObject: Any) {
        
        if let dictionary = jsonObject as? [String: Any] {
            
            if let coord = dictionary["coord"] as? [String: Any] {
                self.lon = coord["lon"] as!  Double
                self.lat = coord["lat"] as! Double
            }
            
            if let weather = dictionary["weather"] as? [String: Any] {
                self.weatherMain = weather["main"]! as! String
                self.weatherDescription = weather["description"]! as! String
            }
            
            if let main = dictionary["main"] as? [String: Any] {
                self.temp = (main["temp"] as?  Double)!
                self.pressure = main["pressure"] as! Double
                self.humidity = main["humidity"] as!  Double
                self.tempMin = main["temp_min"] as! Double
                self.tempMax = main["temp_max"] as!  Double
                self.seaLevel = main["sea_level"] as! Double
            }
            
            if let wind = dictionary["wind"] as? [String: Any] {
                self.windSpeed = wind["speed"] as! Double
                self.windDeg = wind["deg"] as!  Double
            }
            
            if let sys = dictionary["sys"] as? [String: Any] {
                self.sunrise = sys["sunrise"] as! Double
                self.sunset = sys["sunset"] as!  Double
            }
            
            if let name = dictionary["name"] as? String {
                self.name = name
            }
            
        }
    }
}
