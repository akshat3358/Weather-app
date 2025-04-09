//
//  BackgroundView.swift
//  weather-app

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient:
                            Gradient(colors: [
                                WeatherColor.AppBackground,
                                WeatherColor.AppBackground,
                                WeatherColor.AccentColor,
                            ]), startPoint: .top, endPoint: .bottomTrailing)

        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BackgroundView()
}
