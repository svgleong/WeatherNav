//
//  CityRepo.swift
//  WeatherNav
//
//  Created by SofiaLeong on 27/05/2024.
//

import CoreData

//MARK: - Repo to save cities
struct CityRepo {
    func saveCity(data: ReadyData) {
        let moc = DataController.shared.container.viewContext
        
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityName == %@", data.city)
        
        do {
            let savedCities = try moc.fetch(fetchRequest)
            
            // Only saves if there is no city with the same name
            if savedCities.isEmpty {
                let newCity = CityEntity(context: moc)
                
                newCity.cityName = data.city
                newCity.country = data.country
                newCity.lat = data.lat
                newCity.lon = data.lon
                try moc.save()
                print("City saved successfully!")
            }
        } catch {
            print("Error saving city: \(error)")
        }
    }
}
