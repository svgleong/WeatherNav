//
//  WeatherDataParser.swift
//  WeatherNav
//
//  Created by SofiaLeong on 28/05/2024.
//

import Foundation

//MARK: - prepare data for Views

protocol WeatherDataParser {
    func parseData(_ weatherData: WeatherData) -> ReadyData
}

extension WeatherDataParser {
    
    func parseData(_ weatherData: WeatherData) -> ReadyData {
        let city = parseCityName(weatherData)
        let description = parseDescription(weatherData)
        let temp = parseTemperature(weatherData)
        let lat = parseLatitude(weatherData)
        let lon = parseLongitude(weatherData)
        let country = parseCountry(weatherData)
        
        let feelsLike = parseFeelsLike(weatherData)
        let windSpeed = parseWindSpeed(weatherData)
        let humidity = parseHumidity(weatherData)
        let rainProb = parseRainProbability(weatherData)
        
        let days = parseDays(weatherData)
        
        return ReadyData(
            city: city,
            description: description,
            tempHeader: temp,
            lat: lat,
            lon: lon,
            feelsLike: feelsLike,
            windSpeed: windSpeed,
            humidity: humidity,
            rainProb: rainProb,
            country: country,
            days: days
        )
    }
    
    private func parseCityName(_ weatherData: WeatherData) -> String {
        return weatherData.city.name
    }
    
    private func parseDescription(_ weatherData: WeatherData) -> String {
        return weatherData.list.first?.weather.first?.main ?? ""
    }
    
    private func parseTemperature(_ weatherData: WeatherData) -> Double {
        return weatherData.list.first?.main.temp ?? 0.0
    }
    
    private func parseLatitude(_ weatherData: WeatherData) -> Double {
        return weatherData.city.coord.lat
    }
    
    private func parseLongitude(_ weatherData: WeatherData) -> Double {
        return weatherData.city.coord.lon
    }
    
    private func parseCountry(_ weatherData: WeatherData) -> String {
        return weatherData.city.country
    }
    
    private func parseFeelsLike(_ weatherData: WeatherData) -> String {
        let feelsLikeTemp = weatherData.list.first?.main.feels_like ?? 0.0
        return String(format: "%.1f", feelsLikeTemp) + "ºC"
    }
    
    private func parseWindSpeed(_ weatherData: WeatherData) -> String {
        if let windSpeed = weatherData.list.first?.wind.speed {
            return String(windSpeed) + " m/sec"
        }
        return "Error"
    }
    
    private func parseHumidity(_ weatherData: WeatherData) -> String {
        if let humidity = weatherData.list.first?.main.humidity {
            return String(humidity) + "%"
        }
        return "Error"
    }
    
    private func parseRainProbability(_ weatherData: WeatherData) -> String {
        if let rainProb = weatherData.list.first?.pop {
            let percentage = rainProb * 100
            return String(format: "%.0f", percentage) + "%"
        }
        return "Error"
    }
    
    private func parseDays(_ weatherData: WeatherData) -> [Day] {
        var days: [Day] = []
        var list: [ListDetail] = []
        var date = String(weatherData.list.first?.dt_txt.prefix(10) ?? "0000-00-00")
        
        for item in weatherData.list {
            if item.dt_txt.prefix(10) != date {
                days.append(Day(hours: list))
                list = []
                date = String(item.dt_txt.prefix(10))
            }
            list.append(item)
        }
        // Append the last day
        if !list.isEmpty {
            days.append(Day(hours: list))
        }
        
        return days
    }
}
