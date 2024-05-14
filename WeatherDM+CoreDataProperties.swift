//
//  WeatherDM+CoreDataProperties.swift
//  WeatherNav
//
//  Created by SofiaLeong on 13/05/2024.
//
//

import Foundation
import CoreData


extension WeatherDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDM> {
        return NSFetchRequest<WeatherDM>(entityName: "WeatherDM")
    }

    @NSManaged public var descrip: String?
    @NSManaged public var icon: String?
    @NSManaged public var main: String?

}

extension WeatherDM : Identifiable {

}
