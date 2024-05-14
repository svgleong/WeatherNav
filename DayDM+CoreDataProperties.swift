//
//  DayDM+CoreDataProperties.swift
//  WeatherNav
//
//  Created by SofiaLeong on 13/05/2024.
//
//

import Foundation
import CoreData


extension DayDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayDM> {
        return NSFetchRequest<DayDM>(entityName: "DayDM")
    }

    @NSManaged public var hours: NSOrderedSet?

}

// MARK: Generated accessors for hours
extension DayDM {

    @objc(insertObject:inHoursAtIndex:)
    @NSManaged public func insertIntoHours(_ value: ListDM, at idx: Int)

    @objc(removeObjectFromHoursAtIndex:)
    @NSManaged public func removeFromHours(at idx: Int)

    @objc(insertHours:atIndexes:)
    @NSManaged public func insertIntoHours(_ values: [ListDM], at indexes: NSIndexSet)

    @objc(removeHoursAtIndexes:)
    @NSManaged public func removeFromHours(at indexes: NSIndexSet)

    @objc(replaceObjectInHoursAtIndex:withObject:)
    @NSManaged public func replaceHours(at idx: Int, with value: ListDM)

    @objc(replaceHoursAtIndexes:withHours:)
    @NSManaged public func replaceHours(at indexes: NSIndexSet, with values: [ListDM])

    @objc(addHoursObject:)
    @NSManaged public func addToHours(_ value: ListDM)

    @objc(removeHoursObject:)
    @NSManaged public func removeFromHours(_ value: ListDM)

    @objc(addHours:)
    @NSManaged public func addToHours(_ values: NSOrderedSet)

    @objc(removeHours:)
    @NSManaged public func removeFromHours(_ values: NSOrderedSet)

}

extension DayDM : Identifiable {

}
