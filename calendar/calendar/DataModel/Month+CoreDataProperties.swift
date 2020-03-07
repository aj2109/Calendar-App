//
//  Month+CoreDataProperties.swift
//  calendar
//
//  Created by Adam Jessop on 07/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//
//

import Foundation
import CoreData


extension Month {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Month> {
        return NSFetchRequest<Month>(entityName: "Month")
    }

    @NSManaged public var name: String
    @NSManaged public var days: NSSet
    @NSManaged public var year: Year
    @NSManaged public var monthNumber: Int64

}

// MARK: Generated accessors for days
extension Month {

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: Day)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: Day)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSSet)

}
