//
//  DataController.swift
//  WeatherNav
//
//  Created by SofiaLeong on 08/05/2024.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: "Model", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        //let mainBundle = Bundle(for: DataController.self)
        //let paths = mainBundle.paths(forResourcesOfType: nil, inDirectory: nil)
        //print("Bundle contents: \(paths)")
        
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

