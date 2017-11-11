//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ricardo Ceballos Peña on 11/10/17.
//  Copyright © 2017 globant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ConnectionProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var weatherReport: WeatherReport?
    
    var conn : Connection? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conn = Connection(withDelegate:self)
        conn?.start(urlPath: "http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b1b15e88fa797225412429c1c50c122a1")
        
        weatherReport = WeatherReport()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! WeatherReportCell
        
        if let weatherReportLoc = weatherReport {
            cell.descripcionClimaLabel?.text = weatherReportLoc.name
            cell.lonLabel?.text = String(describing: weatherReportLoc.lon)
            cell.latLabel?.text = String(describing: weatherReportLoc.lat)
            cell.humidityLabel?.text = String(describing: weatherReportLoc.humidity)
            cell.pressureLabel?.text = String(describing: weatherReportLoc.pressure)
            cell.tempLabel?.text = String(describing: weatherReportLoc.temp)
            
            cell.tempMaxLabel?.text = String(describing: weatherReportLoc.tempMax)
            cell.tempMinLabel?.text = String(describing: weatherReportLoc.tempMin)
            cell.seaLevelLabel?.text = String(describing: weatherReportLoc.seaLevel)
            cell.windSpeedLabel?.text = String(describing: weatherReportLoc.windSpeed)
            cell.windDegLabel?.text = String(describing: weatherReportLoc.windDeg)
            
            cell.sunriseLabel?.text = String(describing: weatherReportLoc.sunrise)
            cell.sunsetLabel?.text = String(describing: weatherReportLoc.sunset)
        }

        
        return cell
    }
    
    func tableView(_ table: UITableView, numberOfRowsInSection: Int) -> Int  {
        return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func didConnectWithResultData(data : Data) {
        
        let jsonObject = JSONUtil.getJSONFromData(data)
        weatherReport = WeatherReport(jsonObject)
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func didConnectWithError(error : Error) {
        print(error);
    }
}

