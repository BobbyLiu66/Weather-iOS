//
//  CurrentlyWeatherDataDetails.swift
//  weather
//
//  Created by Liu bo on 20/10/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation

struct CurrentlyWeatherDataDetails: Codable {
    let windSpeed: Double
    let cityName: String
    let temperature: Double
    let appTemperature: Double
    let weatherIcon: String
    let weatherCode: String
    let weatherDescription: String
    let sunset: String
    let sunrise: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        
        case sunset
        case sunrise
        case weatherCode = "code"
        case weatherDescription = "description"
        case weatherIcon = "icon"
        case temperature = "temp"
        case windSpeed = "wind_spd"
        case cityName = "city_name"
        case appTemperature = "app_temp"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.temperature = try container.decode(Double.self, forKey: .temperature)
        self.appTemperature = try container.decode(Double.self, forKey: .appTemperature)
        self.cityName = try container.decode(String.self, forKey: .cityName)
        self.sunset = try container.decode(String.self, forKey: .sunset)
        self.sunrise = try container.decode(String.self, forKey: .sunrise)
        
        let weather = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .weather)
        self.weatherCode = try weather.decode(String.self, forKey: .weatherCode)
        self.weatherIcon = try weather.decode(String.self, forKey: .weatherIcon)
        self.weatherDescription = try weather.decode(String.self, forKey: .weatherDescription)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(temperature, forKey: .temperature)
        try container.encode(appTemperature, forKey: .appTemperature)
        try container.encode(cityName, forKey: .cityName)
        try container.encode(sunset, forKey: .sunset)
        try container.encode(sunrise, forKey: .sunrise)
        try container.encode(windSpeed, forKey: .windSpeed)
        
        var weather = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .weather)
        try weather.encode(weatherDescription, forKey: .weatherDescription)
        try weather.encode(weatherIcon, forKey: .weatherIcon)
        try weather.encode(weatherCode, forKey: .weatherCode)
        
    }
    
}
