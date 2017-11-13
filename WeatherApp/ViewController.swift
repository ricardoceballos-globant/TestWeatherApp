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
           
            cell.lonLabel?.text = weatherReportLoc.lon.description
            cell.latLabel?.text =  weatherReportLoc.lat.description
            
            cell.mainLabel?.text =  weatherReportLoc.weatherMain.description
            cell.descLabel?.text =  weatherReportLoc.weatherDescription.description
            
            cell.humidityLabel?.text =  weatherReportLoc.humidity.description
            cell.pressureLabel?.text =  weatherReportLoc.pressure.description
            cell.tempLabel?.text =  weatherReportLoc.temp.description
            
            cell.tempMaxLabel?.text =  weatherReportLoc.tempMax.description
            cell.tempMinLabel?.text =  weatherReportLoc.tempMin.description
            cell.seaLevelLabel?.text =  weatherReportLoc.seaLevel.description
            cell.windSpeedLabel?.text =  weatherReportLoc.windSpeed.description
            cell.windDegLabel?.text =  weatherReportLoc.windDeg.description
            
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .brief
            
            var formattedString = formatter.string(from: weatherReportLoc.sunrise)!
            cell.sunriseLabel?.text =  formattedString
            
            formattedString = formatter.string(from: weatherReportLoc.sunset)!
            cell.sunsetLabel?.text = formattedString
            
             cell.nameLabel?.text = weatherReportLoc.name
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

