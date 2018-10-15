//
//  Weather.swift
//  weather
//
//  Created by Liu bo on 13/10/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation.NSURL

// Query service creates Track objects
struct CurrentWeather {
//    let sample = {
//        "coord":{"lon":-0.13,"lat":51.51},
//        "weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],
//        "base":"stations",
//        "main":{"temp":288.55,"pressure":1009,"humidity":77,"temp_min":288.15,"temp_max":289.15},
//        "visibility":10000,
//        "wind":{"speed":6.2,"deg":190},
//        "clouds":{"all":20},
//        "dt":1539328800,
//        "sys":{"type":1,"id":5093,"message":0.0048,"country":"GB","sunrise":1539325182,"sunset":1539364396},
//        "id":2643743,
//        "name":"London",
//        "cod":200
//    }
    let weatherId : Int
    let weatherDescription : String
    let windSpeed : Double
    let weatherTemp : Double
    let weatherPressure : Double
}

extension CurrentWeather {
    init?(weatherDictionary: [String: Any]) {
        guard let wind = weatherDictionary["wind"] as? [String:Any],
            let main = weatherDictionary["main"] as? [String:Any],
            let weather = weatherDictionary["weather"] as? [Any]
            else {
                return nil
        }
        
        guard let windSpeed = wind["speed"] as? Double,
            let weatherTemp = main["temp"] as? Double,
            let weatherPressure = main["pressure"] as? Double
        else {
            return nil
        }
        
        guard let weatherDetails = weather.first as? [String:Any] else {
            return nil
        }
        
        guard let weatherId = weatherDetails["id"] as? Int,
            let weatherDescription = weatherDetails["description"] as? String
        else { return nil }
        
        self.weatherId = weatherId
        self.weatherDescription = weatherDescription
        self.windSpeed = windSpeed
        self.weatherPressure = weatherPressure
        self.weatherTemp = weatherTemp
    }
}

