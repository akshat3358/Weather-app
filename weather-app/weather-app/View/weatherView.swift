//
//  weatherView.swift
//  weather-app

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack{
                    TextField("Enter city", text: $viewModel.city)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        viewModel.fetchCurrentWeather()
                        viewModel.fetchForecast()
                    }) {
                        Text("Search")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                if let currentWeather = viewModel.currentWeather {
                    VStack {
                        Text("Current Weather in \(viewModel.city)")
                            .font(.title)
                        
                        Text("\(Int(currentWeather.tempC))°C")
                            .font(.system(size: 54))
                            .fontWeight(.semibold)
                        
                        Text(currentWeather.condition.text)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                    .padding()
                }
                
                // Hourly forecast view
                if !viewModel.hourlyForecast.isEmpty {
                    Text("Hourly Forecast")
                        .font(.title2)
                        .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.hourlyForecast) { hourly in
                                HourlySummaryView(
                                    temp: viewModel.timeFor(hourly: hourly),
                                    icon: viewModel.tempFor(hourly: hourly),
                                    time: viewModel.imageFor(hourly: hourly)
                                )
                            }
                        }
                        .padding()
                    }
                }
                
                // 5-day forecast view
                if let forecast = viewModel.forecast {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(forecast.forecast.forecastday) { weather in
                                DayWiseSummaryView(
                                    day: viewModel.dayFor(weatherElement: weather),
                                    highTemp: viewModel.highTempFor(weatherElement: weather),
                                    lowTemp: viewModel.lowTempFor(weatherElement: weather),
                                    icon: viewModel.imageFor(weatherElement: weather)
                                )
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Weather")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
