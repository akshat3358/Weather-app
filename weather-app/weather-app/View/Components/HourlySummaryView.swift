//
//  HourlySummaryView.swift
//  weather-app


import SwiftUI

struct HourlySummaryView: View {
    let temp: String
    let icon: String
    let time: String
    
    var body: some View {
        VStack {
            Text(time)
                .font(.footnote)
                .foregroundColor(.gray)
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text(temp)
                .font(.caption)
        }
        .frame(width: 60)
    }
}
