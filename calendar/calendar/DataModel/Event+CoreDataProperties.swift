//
//  Event+CoreDataProperties.swift
//  calendar
//
//  Created by Adam Jessop on 07/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var descript: String?
    @NSManaged public var important: Bool
    @NSManaged public var title: String
    @NSManaged public var day: Day
    @NSManaged public var fromDate: Date
    @NSManaged public var toDate: Date

}
