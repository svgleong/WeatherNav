//
//  ReadyData.swift
//  WeatherNav
//
//  Created by SofiaLeong on 07/05/2024.
//

import Foundation

struct ReadyData {
    var city: String
    let description: String
    let tempHeader: Double
    let lat: Double
    let lon: Double
    let feelsLike: String
    let windSpeed: String
    let humidity: String
    let rainProb: String
    let country: String
    
    var days: [Day]
    
    var tempString: String {
        return String(format: "%.1f", tempHeader)
    }
    
    func getHour(_ list: ListDetail) -> String {
        return String(list.dt_txt.dropFirst(11).prefix(2))
    }
    
    func getTemperature(_ list: ListDetail) -> String {
        String(format: "%.0f", list.main.temp) + "ºC"
    }
    
    func getIcon(_ list: ListDetail) -> String {
        let icon = list.weather[0].icon

        switch icon {
        case "01d":
            return "sun.max.fill"
        case "01n":
            return "moon.fill"
        case "02d":
            return "cloud.sun.fill"
        case "02n":
            return "cloud.moon.fill"
        case "03d", "03n":
            return "cloud"
        case "09d", "09n":
            return "cloud.rain.fill"
        case "10d":
            return "cloud.sun.rain.fill"
        case "10n":
            return "cloud.moon.rain.fill"
        case "11d", "11n":
            return "cloud.bolt.fill"
        case "13d", "13n":
            return "snowflake"
        case "50d", "50n":
            return "cloud.fog.fill"
        default:
            return "cloud.fill"
        }
    }
}

struct Day {
    var hours: [ListDetail]
}

//MARK: - City info for when connection fails
struct CityInfo: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let country: String
    let lat: Double
    let lon: Double
}
