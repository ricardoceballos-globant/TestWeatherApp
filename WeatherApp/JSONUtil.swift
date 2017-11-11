//
//  JSONUtil.swift
//  WeatherApp
//
//  Created by Ricardo Ceballos Peña on 11/10/17.
//  Copyright © 2017 globant. All rights reserved.
//

import UIKit

class JSONUtil: NSObject {
    
    class func getJSONFromData(_ data :Data ) -> Any? {
        
        var json: Any?
        
        do {
            json = try JSONSerialization.jsonObject(with: data)
        } catch {
            print(error)
            return nil
        }
        return json
    }
}
