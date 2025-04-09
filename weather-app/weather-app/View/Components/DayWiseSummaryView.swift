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
            if let imageUrl = URL(string: "https:" + icon) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .renderingMode(.original)
                        .imageScale(.small)
                } placeholder: {
                    ProgressView()
                }
                .padding()
            } else {
                Text("Invalid URL")
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(Color(.gray))
        .cornerRadius(10)
    }
}
