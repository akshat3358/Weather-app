# Weather-app<a name="readme-top"></a>
A weather app built using SwiftUI, that fetches weather forecast from [weather api][api-url] and displays data to user. It have features like showing 5 days and hourly forecast data for the location entered by the user.

[![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)][Swift-url] [![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)][Xcode-url]

<!-- Technologies Used for this Project -->
<details>
  <summary>Technologies Used for this Project</summary>
  <ol>
    <li>Swift</li>
    <li>SwiftUI Framework</li>
    <li>MVVM Architecture</li>
    <li>Combine Framework</li>
    <li>Json Decoding</li>
  </ol>
</details>

### Prerequisites

- A Valid Api key from [weather api][api-url]

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

### Glance of the app

| Home Screen | Weather Screen | Weather Screen | Weather Screen |
| ------------- | ------------- | ------------- | ------------- |
| ![image alt](https://github.com/akshat3358/Weather-app/blob/main/1.png?raw=true) | ![image alt](https://github.com/akshat3358/Weather-app/blob/main/2.png?raw=true) | ![image alt](https://github.com/akshat3358/Weather-app/blob/main/3.png?raw=true) |  ![image alt](https://github.com/akshat3358/Weather-app/blob/main/4.png?raw=true) |


[Swift-url]: https://docs.swift.org/swift-book/
[Xcode-url]: https://developer.apple.com/xcode/
[api-url]: https://www.weatherapi.com/
