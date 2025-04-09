//
//  APIClient.swift
//  weather-app
import Foundation
import Combine

// MARK: - APIClient
class APIClient {

    static let shared = APIClient() // Singleton instance
    
    private init() {}
    
    // Function to fetch forecast data
    func fetchForecast(for city: String, days: Int) -> AnyPublisher<ForecastResponse, Error> {
        let urlString = "\(AppConstants.Api.apiUrl)forecast.json?key=\(AppConstants.Api.apiKey)&q=\(city)&days=\(days)&aqi=no&alerts=no"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data } // Extract data from the response
            .decode(type: ForecastResponse.self, decoder: JSONDecoder())
            .mapError { error in
                error as? APIError ?? APIError.noData
            }
            .eraseToAnyPublisher()
    }
}

enum APIError: Error {
    case invalidURL
    case noData
}
