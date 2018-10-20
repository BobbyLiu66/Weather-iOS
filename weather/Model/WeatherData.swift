//
//  Weather.swift
//  weather
//
//  Created by Liu bo on 13/10/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let lastObservationTime: Double  //Last observation time (Unix timestamp).
    let cityName:  String //City name.
    let windSpeed:  String //Wind speed (Default m/s).
    let tempreture:  String //Temperature (default Celcius).
    let apparentTemperature:  Double //Apparent/"Feels Like" temperature (default Celcius).
    let icon:  String //Weather icon code.
    let code:  Int? //Weather code.
    let description:   String //Text weather description.
    
    let localTime: String
    let lowestTemp: String
    let highestTemp: String
}

extension WeatherData {
    init?(json weatherDictionary: [String: Any], dataType: QueryDataType) {
        switch dataType {
        case .currently:
            if let apparentTemperature = weatherDictionary["app_temp"] as? Double,
                let cityName = weatherDictionary["city_name"] as? String
                {
                self.apparentTemperature = apparentTemperature
                self.cityName = cityName
            }
            else {
                self.apparentTemperature = 99999
                self.cityName = "nil currently"
            }
            self.localTime = "Date()"
            self.lowestTemp = "nil"
            self.highestTemp = "nil"
        case .hourly:
            let decoder = JSONDecoder()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
//            try? decoder.decode(self.localTime, from: )
            
            
//            let localTime = weatherDictionary["timestamp_local"] as? NSDate,
            if
                let apparentTemperature = weatherDictionary["app_temp"] as? Double{
                self.localTime = "localTime"
                self.apparentTemperature = apparentTemperature
            }
                
            else {
                self.localTime = "nil"
                self.apparentTemperature = 0
            }
            self.lowestTemp = "nil"
            self.highestTemp = "nil"
            self.cityName = "nil"
        case .daily:
            if  let lowestTemp = weatherDictionary["min_temp"] as? Double,
                let highestTemp = weatherDictionary["max_temp"] as? Double {
                self.lowestTemp = lowestTemp.toString()
                self.highestTemp = highestTemp.toString()
            }
            else {
                self.lowestTemp = "nil"
                self.highestTemp = "nil"
            }
            
            self.apparentTemperature = 0
            self.cityName = "nil"
            self.localTime = "nil"
        }
        
        guard let windSpeed = weatherDictionary["wind_spd"] as? Double else {
            return nil
        }
        
        guard let lastObservationTime = weatherDictionary["ts"] as? Double else {
            return nil
        }
        
        guard let tempreture = weatherDictionary["temp"] as? Double else {
            return nil
        }
        
        guard let weather = weatherDictionary["weather"] as? [String: Any] else {
            return nil
        }
        
        guard let icon = weather["icon"] as? String else {
            return nil
        }
        
        guard let description = weather["description"] as? String else {
            return nil
        }
        
        if let code = weather["code"] as? Int {
            self.code = code
        }
        else if let code = weather["code"] as? String {
            self.code = Int(code)
        }
        else {
            self.code = 0
        }
        
        
        self.description = description
        self.icon = icon
        self.lastObservationTime = lastObservationTime
        self.tempreture = tempreture.toString()
        self.windSpeed = windSpeed.toString()

        print(self)
    }
}

