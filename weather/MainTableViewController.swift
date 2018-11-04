//
//  TestTableViewController.swift
//  weather
//
//  Created by Liu bo on 2/11/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mainWeatherTableView: UITableView!
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var weatherCondition: UILabel!
    
    @IBOutlet weak var degree: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView! {
        didSet{
            backgroundImage.image = UIImage(named: "day")
        }
    }
    
    // MARK :- weather data
    var currentlyWeather: [CurrentlyWeatherDataDetails] = []
    
    var hourlyWeather: [HourlyWeatherDataDetails] = []
    
    var dailyWeather: [DailyWeatherDataDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainWeatherTableView.dataSource = self
        mainWeatherTableView.delegate = self
        mainWeatherTableView.backgroundColor = UIColor.clear
        
        self.locationManager.requestWhenInUseAuthorization()
        //TODO: ask if there is no data in local
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        getData(location: currentLocation, inputCity: nil)
    }
    
    func getData(location: CLLocationCoordinate2D?, inputCity: String?) {
        let queryData = QueryData()
        
        queryData.executeMultiTask(location: location, cityName: inputCity, completion: { hourly, currently, daily in
            
            self.currentlyWeather = currently!.first!.weatherDetails
            self.dailyWeather = daily!.first!.weatherDetails
            self.hourlyWeather = hourly!.first!.weatherDetails
            
            self.weatherCondition.text = self.currentlyWeather.first?.weatherDescription
            
            self.degree.text = (self.currentlyWeather.first?.temperature.toString())! + "°"
            
            self.weatherCondition.text = self.currentlyWeather.first?.weatherDescription
            
            self.cityName.text = self.currentlyWeather.first?.cityName
            
            self.mainWeatherTableView.reloadData()
        })
    }
    
    // MARK :- Main table view function
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat
        if indexPath.row == 1 {
            height = 120.0
        } else{
            height = 50.0
        }
        return height
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather.count + 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK :- today forecast
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherTableViewCell", for: indexPath) as! DailyForecastTableViewCell
            cell.today.text = Date().dayOfWeek()!
            cell.highestTemp.text = dailyWeather.first?.hightestTemp.toString()
            cell.lowestTemp.text = dailyWeather.first?.lowestTemp.toString()
            cell.layer.backgroundColor = UIColor.clear.cgColor
            return cell
        }
        else if indexPath.row == 1{
            // MARK :- 12 hours forecast
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailWeatherTableViewCell", for: indexPath) as! HourlyForecastTableViewCell
            cell.hourlyWeatherData = self.hourlyWeather
            cell.hourlyWeatherCollectionView.reloadData()
            cell.layer.backgroundColor = UIColor.clear.cgColor
            return cell
        }
        else {
            // MARK :- 7 days forecast
            let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherTableViewCell", for: indexPath) as! DailyForecastTableViewCell
            if indexPath.row - 1 < dailyWeather.count {
                cell.highestTemp.text = dailyWeather[indexPath.row - 1].hightestTemp.toString()
                cell.lowestTemp.text = dailyWeather[indexPath.row - 1].lowestTemp.toString()
                cell.today.text = dailyWeather[indexPath.row - 1].date.dayOfWeek()!
                cell.weatherIcon.image = UIImage(named: dailyWeather[indexPath.row - 1].weatherIcon)
                cell.layer.backgroundColor = UIColor.clear.cgColor
            }
            
            return cell
        }
        
    }

}


extension Double {
    func toString() -> String {
        return String(format: "%.0f",self)
    }
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
