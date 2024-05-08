//
//  ViewModel.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var showingSheet = false
    @Published var weatherData: ReadyData?
    var hasFailed = false

<<<<<<< HEAD
//    let appid: String = "YOUR_API_KEY"
=======
>>>>>>> f20e376a38b54ce8967250da130eb2aa0ba53356
    
    
    var city: String {
        weatherData?.city ?? ""
    }
    
    var description: String {
        weatherData?.description ?? ""
    }
    
    var temperature: String {
        "\(weatherData?.tempString ?? "")ºC"
    }
    
    func getDay(_ i: Int) -> Day {
        weatherData!.days[i]
    }
    
    var currentSearchText: String {
        searchText
    }

    @MainActor
    func fetchWeatherData(_ searchField: String) async {
        var city = searchField
        if city.isEmpty {
            city = "Lisbon"
        }
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(appid)&units=metric") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            if (decodedData.cod == "200") {
                weatherData = parseData(decodedData)
                searchText = ""
            }
            else {
                print("Error: Response status code is not 200")
                hasFailed = true
            }
        } catch {
            print("Error decoding weather data: \(error)")
            hasFailed = true
            searchText = ""
        }
    }
    
    
    func parseData(_ weatherData: WeatherData) -> ReadyData {
        let city = weatherData.city.name
        let description = weatherData.list[0].weather[0].main
        let temp = weatherData.list[0].main.temp
        let lat = weatherData.city.coord.lat
        let lon = weatherData.city.coord.lon
        
        var feelsLike: String {
            let string = String(format: "%.1f", weatherData.list[0].main.feels_like)
            return string + "ºC"
        }
        
        var windSpeed: String {
            String(weatherData.list[0].wind.speed) + " m/sec"
        }
        
        var humidity: String {
            String(weatherData.list[0].main.humidity) + "%"
        }
        
        var rainProb: String {
            let prob = weatherData.list[0].pop
            let percentage = prob * 100
            return String(format: "%.0f", percentage) + "%"
        }
        
        var days: [Day] = []
        var list: [ListDetail] = []
        
        // Split by day
        var date = String(weatherData.list[0].dt_txt.prefix(10))
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
            days: days
        )
        return data
    }
    
    func getDate(_ i: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if weatherData != nil {
            if i == 0 {
                return "Today"
            }
            if let date = formatter.date(from: weatherData!.days[i].hours[0].dt_txt) {
                let string = date.formatted(date: .complete, time: .omitted)
                return String(string.prefix(string.count - 6))
            }
        }
        return ""
    }
    
    func loadData() async {
        await fetchWeatherData(currentSearchText)
    }
}

