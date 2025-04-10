//
//  AppConstants.swift
//  weather-app
//
//  Created by Akshat Chaturvedi on 09/04/25.
//

import Foundation

struct AppConstants {
    enum Api {
        static let apiUrl = "https://api.weatherapi.com/v1/forecast.json"
        static let apiKey = "0678da5b48454444bab30731250904"
        static let httpsString = "https:"
        
        enum QueryKey: String {
            case apiKey = "key"
            case searchString = "q"
            case aqi = "aqi"
            case alerts = "alerts"
            case numOfDays = "days"
        }
        
        enum QueryValue: String {
            case aqi,alerts = "no"
        }
        
    }
    struct constants {
        static let appTitle = "Weather App"
        static let enterCityPlaceholder = "Enter city"
        static let cross = "xmark.circle.fill"
        static let searchButtonTitle = "Search"
        static let degree = "°C"
        static let sunriseString = "sunrise"
        static let sunsetString = "sunset"
        static let sunMax = "sun.max"
        static let humidity = "humidity"
        static let UV = "UV:"
        static let wind = "wind"
        static let windicon = "arrow.up.right.circle"
        static let emptyString = ""
        static let invalidURL = "Invalid URL"
        
        static let spacing4 = 4.0
        static let spacing6 = 6.0
        static let padding8 = 8.0
        static let padding10 = 10.0
        static let padding5 = 5.0
        static let cornerRadius8 = 8.0
        static let cornerRadius10 = 10.0
        static let opacity = 0.3
        
    }
}
