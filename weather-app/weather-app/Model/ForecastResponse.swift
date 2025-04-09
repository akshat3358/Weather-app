//
//  ForecastResponse.swift
//  weather-app

import Foundation

// Condition struct to represent weather conditions
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

// Astro struct to represent the astronomical data
struct Astro: Codable {
    let sunrise: String
    let sunset: String
    
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
    }
}

// Day struct to represent the forecasted day's weather
struct Day: Codable {
    let maxtempC: Double
    let maxtempF: Double
    let mintempC: Double
    let mintempF: Double
    let condition: Condition
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case condition
        case uv
    }
}

// ForecastDay struct to represent forecast for each day
struct ForecastDay: Codable,Identifiable {
    let id = UUID()
    let date: String
    let dateEpoch: Int
    let day: Day
    let astro: Astro
    let hour: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
        case astro
        case hour
    }
}

// Hour struct to represent the hourly weather data
struct Hour: Codable,Identifiable {
    let id = UUID()
    let timeEpoch: Int
    let time: String
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
        case timeEpoch = "time_epoch"
        case time
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

// WeatherResponse struct to represent the entire API response
struct ForecastResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

// Forecast struct to represent the forecast for multiple days
struct Forecast: Codable {
    let forecastday: [ForecastDay]
}
