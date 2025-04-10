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
        
        let mockCity = "London"
        let mockDays = 3
        
        viewModel.fetchWeather(for: mockCity, days: mockDays)
        
        viewModel.$forecast
            .dropFirst() // Skip the initial nil value
            .sink { [weak self] forecast in
                
                XCTAssertNotNil(forecast)
                XCTAssertNotNil(forecast?.current)
                XCTAssertTrue(forecast?.forecast.forecastday.count ?? 0 > 0)
                
                XCTAssertNotNil(forecast?.current.tempC)
                XCTAssertGreaterThan(forecast?.current.tempC ?? 0, -100)
                
                XCTAssertGreaterThan(forecast?.forecast.forecastday.first?.hour.count ?? 0, 0)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }
        }
    }
    
    func testFetchWeatherFailure() {
        let expectation = self.expectation(description: "API Call Failure")
        
        viewModel.fetchWeather(for: "InvalidCity", days: 3) // fail
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                
                XCTAssertNotNil(errorMessage)
                XCTAssertTrue(((errorMessage?.contains("Failed to fetch forecast")) != nil))
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }
        }
    }
    
    func testTempFor() {
        
        let temp1 = 25.5
        let result1 = viewModel.tempFor(temp: temp1)
        XCTAssertEqual(result1, "25°C")
        
        let temp2 = -5.3
        let result2 = viewModel.tempFor(temp: temp2)
        XCTAssertEqual(result2, "-5°C")
        
    }
    
    func testTimeFor() {
        
        let timestamp1 = 1744260000
        let result1 = viewModel.timeFor(epochTime: timestamp1)
        XCTAssertEqual(result1, "10 AM")
    }
    
    func testDayFor() {
        
        // (e.g., 1st January 2023, which is Sunday)
        let timestamp1 = 1672579200
        let result1 = viewModel.dayFor(epochDate: timestamp1)
        XCTAssertEqual(result1, "Sunday")
        
        
        // a leap year date (e.g., 29th February 2024)
        let timestamp3 = 1709174400
        let result3 = viewModel.dayFor(epochDate: timestamp3)
        XCTAssertEqual(result3, "Thursday")
    }
    
    func testHighTempFor() {
        
        let maxTemp1 = 30.5
        let result1 = viewModel.highTempFor(maxTemp: maxTemp1)
        XCTAssertEqual(result1, "30°C")
        
        let maxTemp2 = -10.3
        let result2 = viewModel.highTempFor(maxTemp: maxTemp2)
        XCTAssertEqual(result2, "-10°C")
    }
    
    func testLowTempFor() {
        
        let minTemp1 = 5.5
        let result1 = viewModel.lowTempFor(minTemp: minTemp1)
        XCTAssertEqual(result1, "5°C")
        
        let minTemp2 = -15.3
        let result2 = viewModel.lowTempFor(minTemp: minTemp2)
        XCTAssertEqual(result2, "-15°C")
    }
    
}
