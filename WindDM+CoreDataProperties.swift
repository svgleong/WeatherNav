//
//  WindDM+CoreDataProperties.swift
//  WeatherNav
//
//  Created by SofiaLeong on 13/05/2024.
//
//

import Foundation
import CoreData


extension WindDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WindDM> {
        return NSFetchRequest<WindDM>(entityName: "WindDM")
    }

    @NSManaged public var speed: Double

}

extension WindDM : Identifiable {

}
