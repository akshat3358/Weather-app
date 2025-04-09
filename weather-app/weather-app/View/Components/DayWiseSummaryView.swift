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
        HStack {
            Text(day)
                .fontWeight(.medium)
            Spacer()
            Text("\(highTemp) / \(lowTemp)")
                .fontWeight(.light)
            if let imageUrl = URL(string: AppConstants.Api.httpsString + icon) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .renderingMode(.original)
                        .imageScale(.small)
                } placeholder: {
                    ProgressView()
                }
                .padding()
            } else {
                Text(AppConstants.constants.invalidURL)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, AppConstants.constants.padding5)
        .background(Color(.gray))
        .cornerRadius(AppConstants.constants.cornerRadius10)
    }
}
