# Weather-app<a name="readme-top"></a>
The weather app is an iOS application that provides users with real-time weather data, that fetches weather forecast from [weather api][api-url]. It have features like showing 5 days and hourly forecast data for the location entered by the user.

This project follows the MVVM (Model-View-ViewModel) architecture to ensure a clean separation of concerns and better state management.

[![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)][Swift-url] [![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)][Xcode-url]

## Table of Contents
- [Features](#features)
- [Assumptions](#assumptions)
- [Architecture](#architecture)
- [Project Folder Structure](#project-folder-structure)
- [API Integration](#api-integration)
- [Installation](#installation)
- [Error Handling](#error-handling)
- [Usage](#usage)
- [Known Issues](#known-issues)
- [Executing Tests](#executing-tests)
- [Coverage Reports](#coverage-reports)
  
## Features

- **Current Weather**: Displays the current temperature, weather conditions, humidity, and wind speed, sunrise , sunset.
- **5-Day Forecast**: Provides weather predictions for the next five days, including temperature highs, lows, and weather conditions.
- **Location Search**: Users can search for weather data by entering city name.
- **Error Handling**: Appropriate messaging for failed requests or bad inputs.

## Assumptions

- The user has a stable internet connection to fetch real-time weather data.
- User should enter the city name accurately , otherwise API Call will fail and no data will be shown.
- The weather API key is correctly configured in the app’s.
- The user is using an iOS device with iOS 17.0+ installed, as the app is built with features and APIs available only in this version and later.
- The app assumes that the network will return valid responses from the weather API. The user will be informed via an error message, if an invalid response is returned from api.


## Architecture

The app uses the **MVVM (Model-View-ViewModel)** architecture to maintain separation between the UI and business logic:

- **Model**: Responsible for holding the weather data (e.g., temperature, humidity, forecast).
- **ViewModel**: Handles the business logic of fetching and processing weather data from the API.
- **View**: Composed of SwiftUI views. It only observes the changes in the ViewModel.

Using this, ensures that viewModel is not tightly coupled to view.

## Project Folder Structure

```
├── weather-app

 ├── Constants
    ├── AppConstants

  ├── ViewModels
    ├── WeatherViewModel

  ├── Views
      ├── Components
        ├── BackgroundView
        ├── DayWiseSummaryView
        ├── HourlySummaryView
    ├── ContentView
    ├── WeatherView
    
  ├── Network
    ├── APIClient
      
  ├── Model
    ├── CurrentWeather
    ├── ForecastResponse
    ├── Location

  ├── Resources
    ├── Assets
    ├── Assets

  ├── weather_appApp

  ├── weather-appTests
    ├── weather_appTests
    ├── WeatherViewModelTests
    
```
- `weather-app.xcodeproj`: The Xcode project file.
- `Constants/`: All types of app constants.
- `ViewModels/`: Contains business logic and data-binding code (MVVM).
- `Views/`: Contains UI components (built with SwiftUI).
- `Network/`: Holds network-related files, such as API requests.
- `Model/`: Contains data models for weather information.
- `Assets.xcassets`: Holds assets used in the app.
- `WeatherForecastingApp`: Defines the app's entry point.

## API Integration

The app integrates with a weather API to fetch real-time data.

- **APIClient.swift**: This class handles network requests to fetch current weather and forecast data using URLSession. The API key is stored securely in AppConstants.

API Example:

let url = "http://api.weatherapi.com/v1/forecast.json?key={apiKey}&q={city}&days={days}"


### Installation

1. Clone or download the project.
2. Open the project in xcode.
3. Replace api key with your weather api key in `AppConstants.swift`. Although api key is already exist in the project, however you can also use your own.
   ```swift
   struct AppConstants {
    struct Api {
        static let apiKey = "Your API Key"
   ```
4. Run the project on simulator.

## Error Handling

Error handling mechanisms are implemented to ensure a smooth user experience:

- **API Errors**: Displays user-friendly messages in case of invalid API responses.

 
## Requirements

- iOS 17.0+
- Xcode 16.0+
- Swift 5.0+

## Known Issue 
- App doesn't support current location weather data. City is required to fetch data.
- Currently, app display Celsius for temperature and kilometers per hour (kph) for wind speed. There is no option to switch to Fahrenheit.

## Executing Tests

- To run your tests, Use the shortcut Command + U.
 - Alternatively, you can run specific tests by clicking the **diamond button** next to the test method name in the code editor.

 ## Coverage Reports

 Open the Coverage Report:

- Go to the **Report Navigator** by clicking the triangle icon on the left sidebar.

Select the recent test run from the list.
Inspect Coverage Data:

- Click on the **"Coverage"** tab at the top of the Report Navigator to see detailed coverage information.
 
You can view coverage for each file, including the percentage of lines covered by tests.
Click on a specific file to see which lines of code were executed during the test runs (covered in green) and which were not (not covered in red).

### Glance of the app

| Home Screen | Weather Screen | Weather Screen | Weather Screen |
| ------------- | ------------- | ------------- | ------------- |
| ![image alt](https://github.com/akshat3358/Weather-app/blob/main/1.png?raw=true) | ![image alt](https://github.com/akshat3358/Weather-app/blob/main/2.png?raw=true) | ![image alt](https://github.com/akshat3358/Weather-app/blob/main/3.png?raw=true) |  ![image alt](https://github.com/akshat3358/Weather-app/blob/main/4.png?raw=true) |


[Swift-url]: https://docs.swift.org/swift-book/
[Xcode-url]: https://developer.apple.com/xcode/
[api-url]: https://www.weatherapi.com/
