//
//  Year+CoreDataProperties.swift
//  calendar
//
//  Created by Adam Jessop on 07/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//
//

import Foundation
import CoreData


extension Year {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Year> {
        return NSFetchRequest<Year>(entityName: "Year")
    }

    @NSManaged public var number: Int64
    @NSManaged public var calendar: Calendar?
    @NSManaged public var months: NSSet?

}

// MARK: Generated accessors for months
extension Year {

    @objc(addMonthsObject:)
    @NSManaged public func addToMonths(_ value: Month)

    @objc(removeMonthsObject:)
    @NSManaged public func removeFromMonths(_ value: Month)

    @objc(addMonths:)
    @NSManaged public func addToMonths(_ values: NSSet)

    @objc(removeMonths:)
    @NSManaged public func removeFromMonths(_ values: NSSet)

}
