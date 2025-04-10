//
//  WeatherViewModel.swift
//  weather-app

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    // Current weather data
    
    @Published var currentWeather: CurrentWeather?
    @Published var forecast: ForecastResponse?
    @Published var hourlyForecast: [Hour] = [] // For Hourly Forecast
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var city: String = ""
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeather(for city: String, days: Int) {
        
        isLoading = true
        APIClient.shared.fetchForecast(for: city, days: days)
            .receive(on: DispatchQueue.main) // Ensure we update UI on the main thread
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.isLoading = false
                    self?.errorMessage = "Failed to fetch forecast: \(error.localizedDescription)"
                case .finished:
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] forecast in
                self?.forecast = forecast
                self?.currentWeather = forecast.current
                self?.hourlyForecast = forecast.forecast.forecastday.first?.hour ?? []
            })
            .store(in: &cancellables) // Retain the subscription
    }
    func resetWeatherData() {
           currentWeather = nil
           forecast = nil
           hourlyForecast = []
           errorMessage = nil
       }
    // Helper methods for formatting data
    func tempFor(temp: Double) -> String {
        return "\(Int(temp))°C"
    }
    
    func imageFor(hourly: Hour) -> String {
        return hourly.condition.icon
    }
    
    func timeFor(epochTime: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        let date = Date(timeIntervalSince1970: TimeInterval(epochTime))
        return formatter.string(from: date)
    }
    
    func dayFor(epochDate: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let date = Date(timeIntervalSince1970: TimeInterval(epochDate))
        
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
    
    func highTempFor(maxTemp: Double) -> String {
        return "\(Int(maxTemp))°C"
    }
    
    func lowTempFor(minTemp: Double) -> String {
        return "\(Int(minTemp))°C"
    }
    
    func imageFor(weatherElement: ForecastDay) -> String {
        return weatherElement.day.condition.icon
    }
}
