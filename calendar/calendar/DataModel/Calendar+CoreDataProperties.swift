//
//  Calendar+CoreDataProperties.swift
//  calendar
//
//  Created by Adam Jessop on 07/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//
//

import Foundation
import CoreData


extension Calendar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Calendar> {
        return NSFetchRequest<Calendar>(entityName: "Calendar")
    }

    @NSManaged public var years: NSSet

}

// MARK: Generated accessors for years
extension Calendar {

    @objc(addYearsObject:)
    @NSManaged public func addToYears(_ value: Year)

    @objc(removeYearsObject:)
    @NSManaged public func removeFromYears(_ value: Year)

    @objc(addYears:)
    @NSManaged public func addToYears(_ values: NSSet)

    @objc(removeYears:)
    @NSManaged public func removeFromYears(_ values: NSSet)

}
