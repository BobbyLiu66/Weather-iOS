//
//  HourlyWeatherData.swift
//  weather
//
//  Created by Liu bo on 20/10/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation

struct HourlyWeatherData: Codable {
    let weatherDetails: [HourlyWeatherDataDetails]
    
    enum CodingKeys: String, CodingKey {
        case weatherDetails = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weatherDetails = try container.decode([HourlyWeatherDataDetails].self, forKey: .weatherDetails)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var weatherDetails = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .weatherDetails)
        try weatherDetails.encode(self.weatherDetails, forKey: .weatherDetails)

    }
}
