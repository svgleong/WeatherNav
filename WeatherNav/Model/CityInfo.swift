//
//  CityInfo.swift
//  WeatherNav
//
//  Created by SofiaLeong on 27/05/2024.
//

import Foundation

//MARK: - City info for when connection fails

struct CityInfo: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let country: String
    let lat: Double
    let lon: Double
}
