//
//  ViewModel.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import SwiftUI

class ViewModel: ObservableObject, WeatherDataParser {
    let service: WeatherService
    let repo: CityRepo
    
    var state: State = .loading
    @Published var searchText = ""
    @Published var showingSheet = false
    var previousData: WeatherData?
    @Published var hasFailed = false
    var currentCity = "Lisbon"

    enum State {
        case loading
        case failure
        case success(model: ReadyData)
        case cachedFailure(model: ReadyData)
    }
    
    init(service: WeatherService, repo: CityRepo) {
        self.service = service
        self.repo = repo
        Task {
            await loadData()
        }
    }
    

    func loadData() async {
        let cityOnScreen = previousData?.city.name
        currentCity = searchText
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
            if let model = previousData {
                handleCachedFailure(model: model)
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
        let data = parseData(model)
        state = .success(model: data)
        previousData = model
        repo.saveCity(data: data)
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
        hasFailed = true
        searchText = ""
    }
}
