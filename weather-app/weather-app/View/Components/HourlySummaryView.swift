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
            if let imageUrl = URL(string: AppConstants.Api.httpsString + icon) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Text(AppConstants.constants.invalidURL)
                        }
                
            Text(temp)
                .font(.caption)
        }
        .frame(width: 60, height: 100)
                .padding(AppConstants.constants.padding10)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(AppConstants.constants.cornerRadius10)
    }
}
