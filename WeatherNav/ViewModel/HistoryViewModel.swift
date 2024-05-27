//
//  HistoryViewModel.swift
//  WeatherNav
//
//  Created by SofiaLeong on 14/05/2024.
//

import Foundation
import CoreData
import SwiftUI

class HistoryViewModel: ObservableObject {
    
    @Published var cities: [CityInfo] = []
    let moc = DataController.shared.container.viewContext
    
    func loadData(_ history: FetchedResults<CityEntity>) {
        cities = []
        for city in history {
            cities.append(
                CityInfo(name: city.cityName ?? "",  
                         country: city.country ?? "",
                         lat: city.lat,
                         lon: city.lon))
        }
    }
}
