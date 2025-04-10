//
//  APIClient.swift
//  weather-app
import Foundation
import Combine

// MARK: - APIClient
class APIClient {

    static let shared = APIClient() // Singleton instance
    
    private init() {}
    
    private let decoder: JSONDecoder = {
           let decoder = JSONDecoder()
           return decoder
       }()
    
    // Function to fetch forecast data
    func fetchForecast(for city: String, days: Int) -> AnyPublisher<ForecastResponse, Error> {
        
        guard let url = buildForecastURL(for: city, days: days) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                let data = result.data

                if let apiError = try? self.decoder.decode(APIErrorResponse.self, from: data) {
                    throw APIError.apiReturnedError(apiError.error.message)
                }

                return data
            }
            .decode(type: ForecastResponse.self, decoder: decoder)
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else if error is DecodingError {
                    return APIError.decodingError(error)
                } else {
                    return APIError.networkError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    private func buildForecastURL(for city: String, days: Int) -> URL? {
        var components = URLComponents(string: AppConstants.Api.apiUrl)
            components?.queryItems = [
                URLQueryItem(name: AppConstants.Api.QueryKey.apiKey.rawValue, value: AppConstants.Api.apiKey),
                URLQueryItem(name: AppConstants.Api.QueryKey.searchString.rawValue, value: city),
                URLQueryItem(name: AppConstants.Api.QueryKey.numOfDays.rawValue, value: "\(days)"),
                URLQueryItem(name: AppConstants.Api.QueryKey.aqi.rawValue, value: AppConstants.Api.QueryValue.aqi.rawValue),
                URLQueryItem(name: AppConstants.Api.QueryKey.alerts.rawValue, value: AppConstants.Api.QueryValue.alerts.rawValue)
            ]
            return components?.url
        }
}
struct APIErrorResponse: Codable {
    let error: APIErrorDetail
}

struct APIErrorDetail: Codable {
    let code: Int
    let message: String
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case badResponse
    case decodingError(Error)
    case networkError(Error)
    case apiReturnedError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .badResponse:
            return "Received an unexpected response from the server."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .apiReturnedError(let message):
            return message
        }
    }
}
