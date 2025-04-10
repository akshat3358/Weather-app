import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        Text(AppConstants.constants.appTitle)
            .font(.subheadline)
            .fontWeight(.semibold)
        
        ZStack {
            BackgroundView()
            
            VStack {
                VStack {
                    searchBarView()
                    
                    // Search Button (activates only when searchText is not empty)
                    Button(action: {
                        viewModel.fetchWeather(for: viewModel.city, days: 5)
                    }) {
                        Text(AppConstants.constants.searchButtonTitle)
                            .foregroundColor(viewModel.city.isEmpty ? .gray : .black)
                            .padding(.horizontal)
                            .padding(AppConstants.constants.padding8)
                            .background(viewModel.city.isEmpty ? Color.gray.opacity(AppConstants.constants.opacity) : Color.blue)
                            .cornerRadius(AppConstants.constants.cornerRadius8)
                    }
                    .disabled(viewModel.city.isEmpty) // Disable if no text is entered
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
                            currentWeatherView(weather: currentWeather)
                        }
                        // Astro details, hourly forecast, and 5-day forecast views
                        astroView()
                        
                        // Hourly forecast view
                        if !viewModel.hourlyForecast.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.hourlyForecast) { hourly in
                                        HourlySummaryView(
                                            temp: viewModel.tempFor(temp: hourly.tempC),
                                            icon: viewModel.imageFor(hourly: hourly),
                                            time: viewModel.timeFor(epochTime: hourly.timeEpoch)
                                        )
                                    }
                                }
                                
                            }.padding()
                        }
                        
                        // 5-day forecast view
                        if let forecast = viewModel.forecast {
                            ForEach(forecast.forecast.forecastday) { weather in
                                DayWiseSummaryView(
                                    day: viewModel.dayFor(epochDate: weather.dateEpoch),
                                    highTemp: viewModel.highTempFor(maxTemp: weather.day.maxtempC),
                                    lowTemp: viewModel.lowTempFor(minTemp: weather.day.mintempC),
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
    private func searchBarView() -> some View {
        HStack{
            TextField(AppConstants.constants.enterCityPlaceholder, text: $viewModel.city)
                .onChange(of: viewModel.city, {
                    viewModel.resetWeatherData()
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            // Clear Button (cross) to reset the text field
            if !viewModel.city.isEmpty {
                Button(action: {
                    viewModel.city = AppConstants.constants.emptyString
                    viewModel.resetWeatherData() // Reset the weather data to default
                }) {
                    Image(systemName: AppConstants.constants.cross)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
        }
    }
    private func currentWeatherView(weather: CurrentWeather) -> some View {
       
            VStack(spacing:AppConstants.constants.spacing4) {
                Spacer()
                Text(viewModel.city)
                    .font(.title)
                    .fontWeight(.medium)
                HStack {
                    if let imageUrl = URL(string: AppConstants.Api.httpsString + weather.condition.icon) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .renderingMode(.original)
                                .imageScale(.small)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text("\(Int(weather.tempC))"+AppConstants.constants.degree)
                        .fontWeight(.semibold)
                }
                
                Text(weather.condition.text)
                    .foregroundColor(.secondary)
            }
    }
    private func astroView() -> some View {
        
        VStack {
            HStack {
                if let astro = viewModel.forecast?.forecast.forecastday.first?.astro,
                   let day = viewModel.forecast?.forecast.forecastday.first?.day {
                    
                    
                    VStack(alignment: .leading, spacing: AppConstants.constants.spacing6) {
                            detailView(text: astro.sunrise,
                                       image: .init(systemName: AppConstants.constants.sunriseString),
                                       offset: .init(width: 0, height: -2))
                            detailView(text: astro.sunset,
                                       image: .init(systemName: AppConstants.constants.sunsetString),
                                       offset: .init(width: 0, height: -2))
                        }
                        
                    Spacer()

                    VStack(alignment: .leading, spacing: AppConstants.constants.spacing6) {
                        detailView(text:  AppConstants.constants.UV + " \(day.uv)",
                                   image: .init(systemName: AppConstants.constants.sunMax))
                        
                        if let humidity = viewModel.currentWeather?.humidity {
                            detailView(text: "\(humidity)",
                                       image: .init(systemName: AppConstants.constants.humidity))
                        }
                    }
                    
                    Spacer()
                        VStack(alignment: .leading, spacing: AppConstants.constants.spacing6) {
                            
                            if let windKph = viewModel.currentWeather?.windKph,let windDir = viewModel.currentWeather?.windDir {
                                detailView(text: windKph.description,
                                           image: .init(systemName: AppConstants.constants.wind))
                                detailView(text: "\(windDir)",
                                           image: .init(systemName: AppConstants.constants.windicon))
                            }
                        }
                    
                }
            }
            .padding()
        }
    }
    private func detailView(text: String, image: Image, offset: CGSize = .zero) -> some View {
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
