//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ricardo Ceballos Peña on 11/10/17.
//  Copyright © 2017 globant. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, ConnectionProtocol, CLLocationManagerDelegate {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var seaLevelLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var windDegLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
        
    var weatherReport: WeatherReport?
    
    var conn : Connection? = nil
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1500.0
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        weatherReport = WeatherReport()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateFields() {
        
        if let weatherReportLoc = weatherReport {
           
            self.lonLabel?.text = weatherReportLoc.lon.description
            self.latLabel?.text =  weatherReportLoc.lat.description
            
            self.mainLabel?.text =  weatherReportLoc.weatherMain.description
            self.descLabel?.text =  weatherReportLoc.weatherDescription.description
            
            self.humidityLabel?.text =  weatherReportLoc.humidity.description
            self.pressureLabel?.text =  weatherReportLoc.pressure.description
            self.tempLabel?.text =  weatherReportLoc.temp.description
            
            self.tempMaxLabel?.text =  weatherReportLoc.tempMax.description
            self.tempMinLabel?.text =  weatherReportLoc.tempMin.description
            self.seaLevelLabel?.text =  weatherReportLoc.seaLevel.description
            self.windSpeedLabel?.text =  weatherReportLoc.windSpeed.description
            self.windDegLabel?.text =  weatherReportLoc.windDeg.description
            
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .brief
            
            var formattedString = formatter.string(from: weatherReportLoc.sunrise)!
            self.sunriseLabel?.text =  formattedString
            
            formattedString = formatter.string(from: weatherReportLoc.sunset)!
            self.sunsetLabel?.text = formattedString
            
            self.nameLabel?.text = weatherReportLoc.name
        }
    }
    
     public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        
        self.conn = Connection(withDelegate:self)
        self.conn?.start(urlPath: "http://samples.openweathermap.org/data/2.5/weather?lat=\(coord.latitude)&lon=\(coord.longitude)&appid=b1b15e88fa797225412429c1c50c122a1")
    }
    
    func tableView(_ table: UITableView, numberOfRowsInSection: Int) -> Int  {
        return 1
        
    }
    
    func didConnectWithResultData(data : Data) {
        
        let jsonObject = JSONUtil.getJSONFromData(data)
        weatherReport = WeatherReport(jsonObject)
        populateFields();
    }
    
    func didConnectWithError(error : Error) {
        print(error);
    }
}
