//
//  ForecastResponse.swift
//  weather-app

import Foundation

struct ForecastResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

