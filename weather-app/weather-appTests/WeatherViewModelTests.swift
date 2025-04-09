//
//  WeatherViewModelTests.swift
//  weather-appTests

import XCTest
import Combine
@testable import weather_app

final class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!
        var cancellables: Set<AnyCancellable>!
        
        override func setUp() {
            super.setUp()
            viewModel = WeatherViewModel()
            cancellables = Set<AnyCancellable>()
        }
        
        override func tearDown() {
            viewModel = nil
            cancellables = nil
            super.tearDown()
        }
        
        func testFetchWeather() {
            let expectation = self.expectation(description: "API Call")
            
            viewModel.fetchWeather(for: "London", days: 3)
            
            
            viewModel.$forecast
                .dropFirst()
                .sink { forecast in
                    // Assert that the forecast data is not nil
                    XCTAssertNotNil(forecast)
                    XCTAssertNotNil(forecast?.current)
                    XCTAssertTrue((forecast?.forecast.forecastday.count)! > 0)
                    expectation.fulfill()
                }
                .store(in: &cancellables)
            
            waitForExpectations(timeout: 5, handler: nil)
        }

}
