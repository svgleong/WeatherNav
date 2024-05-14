//
//  CityDM+CoreDataProperties.swift
//  WeatherNav
//
//  Created by SofiaLeong on 13/05/2024.
//
//

import Foundation
import CoreData


extension CityDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityDM> {
        return NSFetchRequest<CityDM>(entityName: "CityDM")
    }

    @NSManaged public var city: String?
    @NSManaged public var descrip: String?
    @NSManaged public var feelsLike: String?
    @NSManaged public var humidity: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var rainProb: String?
    @NSManaged public var tempHeader: Double
    @NSManaged public var windSpeed: String?
    @NSManaged public var days: NSOrderedSet?

}

// MARK: Generated accessors for days
extension CityDM {

    @objc(insertObject:inDaysAtIndex:)
    @NSManaged public func insertIntoDays(_ value: DayDM, at idx: Int)

    @objc(removeObjectFromDaysAtIndex:)
    @NSManaged public func removeFromDays(at idx: Int)

    @objc(insertDays:atIndexes:)
    @NSManaged public func insertIntoDays(_ values: [DayDM], at indexes: NSIndexSet)

    @objc(removeDaysAtIndexes:)
    @NSManaged public func removeFromDays(at indexes: NSIndexSet)

    @objc(replaceObjectInDaysAtIndex:withObject:)
    @NSManaged public func replaceDays(at idx: Int, with value: DayDM)

    @objc(replaceDaysAtIndexes:withDays:)
    @NSManaged public func replaceDays(at indexes: NSIndexSet, with values: [DayDM])

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: DayDM)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: DayDM)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSOrderedSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSOrderedSet)

}

extension CityDM : Identifiable {

}
