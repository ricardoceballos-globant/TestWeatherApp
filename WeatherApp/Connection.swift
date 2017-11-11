//
//  Connection.swift
//  WeatherApp
//
//  Created by Ricardo Ceballos Peña on 11/10/17.
//  Copyright © 2017 globant. All rights reserved.
//

import UIKit

protocol ConnectionProtocol {
    
    func didConnectWithResultData(data : Data)
    func didConnectWithError(error : Error)
}

class Connection: NSObject {
    
    var delegate:ConnectionProtocol
    
    init (withDelegate delegate: ConnectionProtocol) {
        self.delegate = delegate
    }
    
    func start(urlPath:String) {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: urlPath)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                self.delegate.didConnectWithError(error: error!)
                
            } else {
                self.delegate.didConnectWithResultData(data: data!)
            }
            
        })
        task.resume()

    }
}
