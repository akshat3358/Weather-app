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
            if let imageUrl = URL(string: "https:" + icon) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Text("Invalid URL")
                        }
                
            Text(temp)
                .font(.caption)
        }
        .frame(width: 60, height: 100)
                .padding(10)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
    }
}
