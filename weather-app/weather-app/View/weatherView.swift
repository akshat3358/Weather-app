//
//  weatherView.swift
//  weather-app

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        Text("Weather App")
            .font(.subheadline)
            .fontWeight(.semibold)
        ZStack {
            BackgroundView()
            VStack {
                VStack{
                    TextField("Enter city", text: $viewModel.city,onCommit: {
                        viewModel.fetchForecast()
                    })
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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
                
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        if let currentWeather = viewModel.currentWeather {
                            VStack(spacing:4) {
                                Text(viewModel.city)
                                    .font(.title)
                                    .fontWeight(.medium)
                                HStack {
                                    if let imageUrl = URL(string: "https:" + currentWeather.condition.icon) {
                                        AsyncImage(url: imageUrl) { image in
                                            image
                                                .renderingMode(.original)
                                                .imageScale(.small)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                    }
                                    Text("\(Int(currentWeather.tempC))°C")
                                        .fontWeight(.semibold)
                                }
                                
                                Text(currentWeather.condition.text)
                                    .foregroundColor(.secondary)
                            }
                        }
                        VStack {
                            ZStack {
                                if let astro = viewModel.forecast?.forecast.forecastday.first?.astro,
                                   let day = viewModel.forecast?.forecast.forecastday.first?.day {
                                    
                                    HStack {
                                        VStack(alignment: .leading, spacing: 6) {
                                            detailView(text: astro.sunrise,
                                                       image: .init(systemName: "sunrise"),
                                                       offset: .init(width: 0, height: -2))
                                            detailView(text: astro.sunset,
                                                       image: .init(systemName: "sunset"),
                                                       offset: .init(width: 0, height: -2))
                                        }
                                        Spacer()
                                    }

                                    VStack(alignment: .leading, spacing: 6) {
                                        detailView(text: "UV: \(day.uv)",
                                                   image: .init(systemName: "sun.max"))
                                        
                                        if let humidity = viewModel.currentWeather?.humidity {
                                            detailView(text: "\(humidity)",
                                                       image: .init(systemName: "humidity"))
                                        }
                                        
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        VStack(alignment: .leading, spacing: 6) {
                                            
                                            if let windKph = viewModel.currentWeather?.windKph {
                                                detailView(text: windKph.description,
                                                           image: .init(systemName: "wind"))
                                                detailView(text: "\(windKph)",
                                                           image: .init(systemName: "arrow.up.right.circle"))
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        // Hourly forecast view
                        if !viewModel.hourlyForecast.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.hourlyForecast) { hourly in
                                        let time = viewModel.timeFor(hourly: hourly)
                                        let temp = viewModel.tempFor(hourly: hourly)
                                        let icon = viewModel.imageFor(hourly: hourly)
                                        HourlySummaryView(
                                            temp: temp,
                                            icon: icon,
                                            time: time
                                        )
                                    }
                                }
                                
                            }.padding()
                        }
                        
                        // 5-day forecast view
                        if let forecast = viewModel.forecast {
                            ForEach(forecast.forecast.forecastday) { weather in
                                DayWiseSummaryView(
                                    day: viewModel.dayFor(weatherElement: weather),
                                    highTemp: viewModel.highTempFor(weatherElement: weather),
                                    lowTemp: viewModel.lowTempFor(weatherElement: weather),
                                    icon: viewModel.imageFor(weatherElement: weather)
                                )
                            }.padding(.horizontal)
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    @ViewBuilder func detailView(text: String, image: Image, offset: CGSize = .zero) -> some View {
        HStack {
            image
                .imageScale(.medium)
                .offset(offset)
            Text(text)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
