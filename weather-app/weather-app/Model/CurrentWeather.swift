//
//  CurrentWeather.swift
//  weather-app
//
//  Created by Akshat Chaturvedi on 09/04/25.
//

import Foundation
// Current struct to represent the current weather data
struct CurrentWeather: Codable {
   
    let tempC: Double
    let tempF: Double
    
    let condition: Condition
    let windMph: Double
    let windKph: Double
    let windDir: String
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDir = "wind_dir"
        case humidity
        case cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case uv
    }
}
