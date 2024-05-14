//
//  ListDM+CoreDataProperties.swift
//  WeatherNav
//
//  Created by SofiaLeong on 13/05/2024.
//
//

import Foundation
import CoreData


extension ListDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListDM> {
        return NSFetchRequest<ListDM>(entityName: "ListDM")
    }

    @NSManaged public var dt_txt: String?
    @NSManaged public var pop: Double
    @NSManaged public var main: MainDM?
    @NSManaged public var weather: NSOrderedSet?
    @NSManaged public var wind: WindDM?

}

// MARK: Generated accessors for weather
extension ListDM {

    @objc(insertObject:inWeatherAtIndex:)
    @NSManaged public func insertIntoWeather(_ value: WeatherDM, at idx: Int)

    @objc(removeObjectFromWeatherAtIndex:)
    @NSManaged public func removeFromWeather(at idx: Int)

    @objc(insertWeather:atIndexes:)
    @NSManaged public func insertIntoWeather(_ values: [WeatherDM], at indexes: NSIndexSet)

    @objc(removeWeatherAtIndexes:)
    @NSManaged public func removeFromWeather(at indexes: NSIndexSet)

    @objc(replaceObjectInWeatherAtIndex:withObject:)
    @NSManaged public func replaceWeather(at idx: Int, with value: WeatherDM)

    @objc(replaceWeatherAtIndexes:withWeather:)
    @NSManaged public func replaceWeather(at indexes: NSIndexSet, with values: [WeatherDM])

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherDM)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherDM)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSOrderedSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSOrderedSet)

}

extension ListDM : Identifiable {

}
