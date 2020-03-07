//
//  CoreDataManager.swift
//  calendar
//
//  Created by Adam Jessop on 07/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataManager {
    
    static var shared = CoreDataManager()
    static var calendar = NSManagedObject()
    static var years = [NSManagedObject]()
    static var months = [NSManagedObject]()
    static var days = [NSManagedObject]()
    
    func setupData() {
        let managedContext = getContext()
        guard
            let calendarDescription = NSEntityDescription.entity(forEntityName: "Calendar", in: managedContext),
            let yearsDescription = NSEntityDescription.entity(forEntityName: "Year", in: managedContext),
            let monthsDescription = NSEntityDescription.entity(forEntityName: "Month", in: managedContext),
            let daysDescription = NSEntityDescription.entity(forEntityName: "Day", in: managedContext)
        else {
            return
        }
        setupCalendar(calendar: calendarDescription)
        setupYears(calendar: calendarDescription, years: yearsDescription)
        
    }
    
    private func setupCalendar(calendar: NSEntityDescription) {
        let person = NSManagedObject(entity: entity,
        insertInto: managedContext)

    }
    
    private func setupYears(calendar: NSEntityDescription, years: NSEntityDescription) {
        let currentYear = DateManager.getCurrentYear()
        let startDate = currentYear - 50
        for year in 0..<100 {
        }
    }
    
    
    
    
    func saveEvent() {
//        let managedContext = getContext()
//        guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext) else {
//            return
//        }
//        let day = NSManagedObject(entity: entity, insertInto: managedContext)
//        person.setValue(name, forKeyPath: "name")
//        do {
//            try managedContext.save()
//            people.append(person)
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
    }

private func getContext() -> NSManagedObjectContext {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    }
    return appDelegate.persistentContainer.viewContext
}
    
    
}
