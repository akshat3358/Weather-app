//
//  DayWiseSummaryView.swift
//  weather-app


import SwiftUI

struct DayWiseSummaryView: View {
    let day: String
    let highTemp: String
    let lowTemp: String
    let icon: String
    
    var body: some View {
        VStack {
            Text(day)
                .font(.headline)
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text("\(highTemp) / \(lowTemp)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}
