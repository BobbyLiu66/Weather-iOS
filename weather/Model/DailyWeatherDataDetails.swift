//
//  DailyWeatherDataDetails.swift
//  weather
//
//  Created by Liu bo on 20/10/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation

struct DailyWeatherDataDetails: Codable {
    let windSpeed: Double
    let temperature: Double
    let lowestTemp: Double
    let hightestTemp: Double
    
    let weatherIcon: String
    let weatherCode: Int
    let weatherDescription: String
    
    
    
    enum CodingKeys: String, CodingKey {
        case weather
        
        case windSpeed = "wind_spd"
        case temperature = "temp"
        case lowestTemp = "min_temp"
        case hightestTemp = "max_temp"
        case weatherCode = "code"
        case weatherDescription = "description"
        case weatherIcon = "icon"
        
        }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.temperature = try container.decode(Double.self, forKey: .temperature)
        self.lowestTemp = try container.decode(Double.self, forKey: .lowestTemp)
        self.hightestTemp = try container.decode(Double.self, forKey: .hightestTemp)
        
        let weather = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .weather)
        self.weatherCode = try weather.decode(Int.self, forKey: .weatherCode)
        self.weatherIcon = try weather.decode(String.self, forKey: .weatherIcon)
        self.weatherDescription = try weather.decode(String.self, forKey: .weatherDescription)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(temperature, forKey: .temperature)
        try container.encode(lowestTemp, forKey: .lowestTemp)
        try container.encode(hightestTemp, forKey: .hightestTemp)
        try container.encode(windSpeed, forKey: .windSpeed)
        
        var weather = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .weather)
        try weather.encode(weatherDescription, forKey: .weatherDescription)
        try weather.encode(weatherIcon, forKey: .weatherIcon)
        try weather.encode(weatherCode, forKey: .weatherCode)
        
    }
    
}
