//
//  Weather.swift
//  weather-app

import Foundation


struct CurrentWeather: Codable {
    let tempC: Double
    let tempF: Double
    let condition: WeatherCondition
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
            case windKph = "wind_kph"
            case windDir = "wind_dir"
            case humidity, cloud
            case feelslikeC = "feelslike_c"
            case feelslikeF = "feelslike_f"
            case uv
        }
}


struct Forecast: Codable {
    let forecastday: [ForecastDay]
}


struct ForecastDay: Codable,Identifiable {
    let id = UUID()
    let date: String
    let day: Day
    let dateEpoch: Int
    let astro: Astro
    let hour: [HourlyForecast]

    enum CodingKeys: String, CodingKey {
        case date ,dateEpoch = "date_epoch", day, astro, hour
    }
}


struct Day: Codable {
    let maxtempC: Double
    let maxtempF: Double
    let mintempC: Double
    let mintempF: Double
    let condition: WeatherCondition
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case condition, uv
    }
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
    }
}


struct HourlyForecast: Codable,Identifiable {
    let id = UUID()
    let time: String
    let tempC: Double
    let tempF: Double
    let timeEpoch: Int
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time, tempC = "temp_c", tempF = "temp_f", condition
    }
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
    let code: Int
}
