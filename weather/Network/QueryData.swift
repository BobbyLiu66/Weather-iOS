//
//  QueryData.swift
//  weather
//
//  Created by Liu bo on 8/10/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation
class QueryData {
    
    var weatherData : [CurrentWeather] = []
    
    var dataTask: URLSessionDataTask?
    
    var errorMessage = ""
    
    let defaultSession = URLSession(configuration: .default)
    
    func getSearchResults(searchTerm: String, completion: @escaping ([CurrentWeather]?)->()) {
        // 1
        dataTask?.cancel()
        // 2
        if var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") {
            //FIXME: appID different type of parameter
            urlComponents.query = "q=London&APPID=676fb922b841e438eab020fcd29eaba6&units=metric"
            // 3
            guard let url = urlComponents.url else { return }
            // 4
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                // 5
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateSearchResults(data)
                    // 6
                    DispatchQueue.main.async {
                        completion(self.weatherData)
                    }
                }
            }
            // 7
            dataTask?.resume()
        }
    }
    
    func updateSearchResults(_ data: Data) {
        weatherData.removeAll()
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if let weather = CurrentWeather(weatherDictionary: json!) {
                weatherData.append(weather)
            }
        }
    }
}
