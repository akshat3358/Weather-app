//
//  WeatherViewModel.swift
//  weather-app

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    // Current weather data
    
    @Published var currentWeather: CurrentWeather?
        @Published var forecast: ForecastResponse?
        @Published var hourlyForecast: [HourlyForecast] = [] // For Hourly Forecast
        @Published var isLoading = false
        @Published var errorMessage: String?
        @Published var city: String = ""
    
   
    
    func fetchCurrentWeather() {
           isLoading = true
           APIClient.shared.fetchCurrentWeather(for: city) { [weak self] result in
               DispatchQueue.main.async {
                   self?.isLoading = false
                   switch result {
                   case .success(let weather):
                       self?.currentWeather = weather
                   case .failure(let error):
                       self?.errorMessage = "Failed to fetch current weather: \(error.localizedDescription)"
                   }
               }
           }
       }
    
    func fetchForecast() {
        isLoading = true
        APIClient.shared.fetchForecast(for: city, days: 5) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let forecast):
                    self?.forecast = forecast
                    self?.hourlyForecast = forecast.forecast.forecastday.first?.hour ?? []
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch forecast: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func tempFor(hourly: HourlyForecast) -> String {
        return "\(Int(hourly.tempC))°C"
    }
    
    func imageFor(hourly: HourlyForecast) -> String {
        return hourly.condition.icon
    }
    
    func timeFor(hourly: HourlyForecast) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        let date = Date(timeIntervalSince1970: TimeInterval(hourly.timeEpoch))
        return formatter.string(from: date)
    }
    
    func dayFor(weatherElement: ForecastDay) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let date = Date(timeIntervalSince1970: TimeInterval(weatherElement.dateEpoch))
        return formatter.string(from: date)
    }
    
    func highTempFor(weatherElement: ForecastDay) -> String {
        return "\(Int(weatherElement.day.maxtempC))°C"
    }
    
    func lowTempFor(weatherElement: ForecastDay) -> String {
        return "\(Int(weatherElement.day.mintempC))°C"
    }
    
    func imageFor(weatherElement: ForecastDay) -> String {
        return weatherElement.day.condition.icon
    }
}
