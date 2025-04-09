//
//  APIClient.swift
//  weather-app
import Foundation

// MARK: - APIClient
class APIClient {
    
    static let shared = APIClient() // Singleton instance
    
    private let baseURL = "https://api.weatherapi.com/v1/"
    private let apiKey = "Enter your api key here"
    
    private init() {}
    
    // Function to fetch forecast data
    func fetchForecast(for city: String, days: Int, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
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
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }
            
            do {
                let forecastData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(forecastData))
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
