//
//  Location.swift
//  weather-app


import Foundation

struct Location: Codable, Identifiable {
    let id = UUID()
    let name: String
    let country: String?
    let region: String?
}
