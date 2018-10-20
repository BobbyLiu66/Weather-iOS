//
//  QueryData.swift
//  weather
//
//  Created by Liu bo on 8/10/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation

enum QueryDataType: String {
    case hourly, currently, daily
}

class QueryData {
    
    var currentlyWeatherResult : [CurrentlyWeatherData] = []
    
    var hourlyWeatherResult : [HourlyWeatherData] = []
    
    var dailyWeatherResult : [DailyWeatherData] = []
    
    var dataTask: URLSessionDataTask?
    
    var errorMessage = ""
    
    let defaultSession = URLSession(configuration: .default)
    
    //FIXME: queryType should be an enum with daily or hourly
    
    func executeMultiTask(completion: @escaping ([HourlyWeatherData]?, [CurrentlyWeatherData]?, [DailyWeatherData]?)->()) {
        //TODO: instance need to be stored seperately
        let endpoint = "https://api.weatherbit.io/v2.0"
        
        enum queryType: String {
            case hourly = "/forecast/hourly"
            case daily = "/forecast/daily"
            case current = "/current"
        }
        
        
        
        //FIXME: based on location and based on city name (need a new api to match input city name in version 2)
        let newQuery = "city=London,UK&key=418b3cace1ac4ba39df2498460018436&hours=2&days=2"
        
        let taskGroup = DispatchGroup()
        
        // MARK:- Update hourly forcast data next 12 hours
        taskGroup.enter()
        guard var hourlyUrlComponents = URLComponents(string: endpoint + queryType.hourly.rawValue) else {
            return
        }
        hourlyUrlComponents.query = newQuery
        TaskManager.shared.dataTask(with: hourlyUrlComponents.url!) { (data, response, error) in
            if let error = error {
                self.errorMessage += "hourly data error: " + error.localizedDescription + "\n"
            } else if let hourlyData = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let hourlyResult = try! JSONDecoder().decode(HourlyWeatherData.self, from: hourlyData)
                
                self.hourlyWeatherResult.removeAll()
                
                self.hourlyWeatherResult.append(hourlyResult)
                
                taskGroup.leave()
            }
        }
        
        //MARK:- Update daily data
        taskGroup.enter()
        guard var dailyUrlComponents = URLComponents(string: endpoint + queryType.daily.rawValue) else {
            return
        }
        dailyUrlComponents.query = newQuery
        TaskManager.shared.dataTask(with: dailyUrlComponents.url!) { (data, response, error) in
            if let error = error {
                self.errorMessage += "daily data error: " + error.localizedDescription + "\n"
            } else if let dailyData = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let dailyResult = try! JSONDecoder().decode(DailyWeatherData.self, from: dailyData)
                
                self.dailyWeatherResult.removeAll()
                
                self.dailyWeatherResult.append(dailyResult)
                
                taskGroup.leave()
            }
        }
        
        //MARK:- Update currently data
        taskGroup.enter()
        guard var currentlyUrlComponents = URLComponents(string: endpoint + queryType.current.rawValue) else {
            return
        }
        currentlyUrlComponents.query = newQuery
        TaskManager.shared.dataTask(with: currentlyUrlComponents.url!) { (data, response, error) in
            if let error = error {
                self.errorMessage += "currently data error: " + error.localizedDescription + "\n"
            } else if let currentlyData = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let currentlyResult = try! JSONDecoder().decode(CurrentlyWeatherData.self, from: currentlyData)
                
                self.currentlyWeatherResult.removeAll()
                
                self.currentlyWeatherResult.append(currentlyResult)
                
                taskGroup.leave()
            }
        }
        
        
        //4. Notify when all task completed
        taskGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            completion(self.hourlyWeatherResult, self.currentlyWeatherResult, self.dailyWeatherResult)
        }))
        
    }
}
