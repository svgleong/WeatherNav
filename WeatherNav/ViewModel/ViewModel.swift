//
//  ViewModel.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import Foundation
import SwiftUI
import CoreData
import SystemConfiguration

class ViewModel: ObservableObject {
    let service: WeatherService
    let repo = CityRepo()
    
    var state: State = .loading
    @Published var searchText = ""
    @Published var showingSheet = false
    var previousData: WeatherData?
    var hasFailed = false

    enum State {
        case loading
        case failure
        case success(model: ReadyData)
        case cachedFailure(model: ReadyData)
    }
    
    init(service: WeatherService) {
        self.service = service
    }
    
    var currentCity = "Lisbon"
    
    func loadData() async {
        let cityOnScreen = previousData?.city.name
        if cityOnScreen != currentCity {
            await fetchWeatherData(searchText)
        }
    }
}

//MARK: - fetch weather data

extension ViewModel {
    @MainActor
    func fetchWeatherData(_ searchField: String) async {
        var city = searchField
        currentCity = city
        if city.isEmpty {
            city = "Lisbon"
        }
        
        do {
            let model = try await service.fetchWeatherData(for: city)
            handleSuccess(model: model)
        } catch {
            if previousData != nil {
                handleCachedFailure(model: previousData!)
            }
            else {
                handleFailure()
            }
        }
    }
}

//MARK: - handle app states

extension ViewModel {
    func handleSuccess(model: WeatherData) {
        let readyData = parseData(model)
        state = .success(model: readyData)
        previousData = model
        repo.saveCity(data: readyData)
        hasFailed = false
        searchText = ""
    }
    
    func handleCachedFailure(model: WeatherData) {
        state = .cachedFailure(model: parseData(model))
        hasFailed = true
        searchText = ""
    }
    
    func handleFailure() {
        state = .failure
        searchText = ""
    }
}

//MARK: - prepare data for Views

extension ViewModel {
    func parseData(_ weatherData: WeatherData) -> ReadyData {
        let city = weatherData.city.name
        let description = weatherData.list.first?.weather.first?.main ?? ""
        let temp = weatherData.list.first?.main.temp ?? 0.0
        let lat = weatherData.city.coord.lat
        let lon = weatherData.city.coord.lon
        let country = weatherData.city.country
        
        var feelsLike: String {
            let string = String(format: "%.1f", weatherData.list.first?.main.feels_like ?? 0.0)
            return string + "ºC"
        }
        
        var windSpeed: String {
            if weatherData.list.first?.wind.speed != nil {
                return String(weatherData.list[0].wind.speed) + " m/sec"
            }
            return "Error"
        }
        
        var humidity: String {
            if weatherData.list.first?.main.humidity != nil {
                return String(weatherData.list[0].main.humidity) + "%"
            }
            return "Error"
        }
        
        var rainProb: String {
            if weatherData.list.first?.pop != nil {
                let prob = weatherData.list[0].pop
                let percentage = prob * 100
                return String(format: "%.0f", percentage) + "%"
            }
            return "Error"
        }
        
        var days: [Day] = []
        var list: [ListDetail] = []
        
        // Split by day
        var date = String(weatherData.list.first?.dt_txt.prefix(10) ?? "0000-00-00")
        for i in weatherData.list.indices {
            if weatherData.list[i].dt_txt.prefix(10) != date {
                let tempDay = Day(hours: list)
                days.append(tempDay)
                list = []
                date = String(weatherData.list[i].dt_txt.prefix(10))
                list.append(weatherData.list[i])
            }
            else {
                list.append(weatherData.list[i])
            }
        }
        
        let data = ReadyData(
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
        return data
    }
}
