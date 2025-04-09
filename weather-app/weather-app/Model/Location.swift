//
//  Location.swift
//  weather-app

import Foundation
// Location struct to represent location information
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, country
    }
}
