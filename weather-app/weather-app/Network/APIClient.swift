//
//  APIClient.swift
//  weather-app
import Foundation

// MARK: - APIClient
class APIClient {
    
    static let shared = APIClient() // Singleton instance
    
    private let baseURL = "https://api.weatherapi.com/v1/"
    private let apiKey = "Replace with your actual API key"
    
    private init() {}
    
    // Function to fetch forecast data
    func fetchForecast(for city: String, days: Int, completion: @escaping (Result<ForecastResponse, Error>) -> Void) {
            let urlString = "\(baseURL)forecast.json?key=\(apiKey)&q=\(city)&days=\(days)&aqi=no&alerts=no"
            
            guard let url = URL(string: urlString) else {
                completion(.failure(APIError.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(APIError.noData))
                    return
                }
                
                do {
                    let forecastData = try JSONDecoder().decode(ForecastResponse.self, from: data)
                    completion(.success(forecastData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    
    func fetchCurrentWeather(for city: String, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
           let urlString = "\(baseURL)current.json?key=\(apiKey)&q=\(city)&aqi=no"
           
           guard let url = URL(string: urlString) else {
               completion(.failure(APIError.invalidURL))
               return
           }
           
           URLSession.shared.dataTask(with: url) { data, _, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }
               
               guard let data = data else {
                   completion(.failure(APIError.noData))
                   return
               }
               
               do {
                   let weatherData = try JSONDecoder().decode(CurrentWeather.self, from: data)
                   completion(.success(weatherData))
               } catch {
                   completion(.failure(error))
               }
           }.resume()
       }
}
enum APIError: Error {
    case invalidURL
    case noData
}
