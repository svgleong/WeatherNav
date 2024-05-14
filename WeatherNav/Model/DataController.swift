//
//  DataController.swift
//  WeatherNav
//
//  Created by SofiaLeong on 08/05/2024.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container: NSPersistentContainer
    
    // Singleton
    static let shared = DataController()
    
    private init() {
        container = NSPersistentContainer(name: "WeatherModel")
        
        guard Bundle(for: type(of: self)).url(forResource: "WeatherModel", withExtension:"momd") != nil else {
            fatalError("Error loading model from bundle")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Unable to save changes: \(error.localizedDescription)")
            }
        }
    }
}

