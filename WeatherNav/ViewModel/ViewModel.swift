//
//  ViewModel.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import Foundation
import SwiftUI

//extension ViewModel {
    
    struct ReadyData {
        let city: String
        let description: String
        let tempHeader: Double
        let lat: Double
        let lon: Double
        
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
            case "03d":
                return "cloud.fill"
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
//}

class ViewModel: ObservableObject {
    @Published var weatherData: ReadyData?
    var latitude: String = "38.7077507"
    var longitude: String = "-9.1365919"
    
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

//    @MainActor
    func fetchWeatherData() async {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=7387b76e9dd3fb79c023720b2c4fe133&units=metric") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedData = try? JSONDecoder().decode(WeatherData.self, from: data) {
                weatherData = parseData(decodedData)
            }
        } catch {
            print("Error decoding weather data: \(error)")
        }
    }
    
    func parseData(_ weatherData: WeatherData) -> ReadyData {
        let city = weatherData.city.name
        let description = weatherData.list[0].weather[0].main
        let temp = weatherData.list[0].main.temp
        let lat = weatherData.city.coord.lat
        let lon = weatherData.city.coord.lon
        
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
    
    
}
