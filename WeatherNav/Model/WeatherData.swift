//
//  WeatherData.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import Foundation

// JSON schema
struct WeatherData: Decodable {
    let cod: String
    let list: [ListDetail]
    let city: City
}

struct ListDetail: Decodable {
    let main: MainDetail
    let weather: [Weather]
    let wind: Wind
    let pop: Double
    let dt_txt: String
}

struct MainDetail: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
}

struct City: Decodable {
    let name: String
    let coord: Coordinates
    let country: String
}

struct Coordinates: Decodable {
    let lat: Double
    let lon: Double
}
