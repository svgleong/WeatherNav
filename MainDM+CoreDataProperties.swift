//
//  MainDM+CoreDataProperties.swift
//  WeatherNav
//
//  Created by SofiaLeong on 13/05/2024.
//
//

import Foundation
import CoreData


extension MainDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainDM> {
        return NSFetchRequest<MainDM>(entityName: "MainDM")
    }

    @NSManaged public var feels_like: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var temp: Double
    @NSManaged public var temp_max: Double
    @NSManaged public var temp_min: Double

}

extension MainDM : Identifiable {

}
