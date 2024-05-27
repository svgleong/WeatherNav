//
//  WeatherService.swift
//  WeatherNav
//
//  Created by SofiaLeong on 24/05/2024.
//

import Foundation

struct WeatherService {
    let client: WeatherAPIClient
}

extension WeatherService {
    func fetchWeatherData(for city: String) async throws -> WeatherData {
        let endpoint = WeatherEndpoint(city: city)
        let data = try await client.fetchData(endpoint: endpoint)
        return try model(from: data, as: WeatherData.self)
    }
}

extension WeatherService: ModelDecodable {}
