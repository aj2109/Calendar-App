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
    var calendar: Calendar?
    
    func setupData() {
        let context = getContext()
        guard
            let calendarDescription = NSEntityDescription.entity(forEntityName: "Calendar", in: context),
            let yearsDescription = NSEntityDescription.entity(forEntityName: "Year", in: context),
            let monthsDescription = NSEntityDescription.entity(forEntityName: "Month", in: context),
            let daysDescription = NSEntityDescription.entity(forEntityName: "Day", in: context)
            else {
                return
        }
        setupCalendar(calendar: calendarDescription, context: context)
        setupYears(years: yearsDescription, context: context)
        setupMonths(months: monthsDescription, days: daysDescription, context: context)
    }
    
    private func setupCalendar(calendar: NSEntityDescription, context: NSManagedObjectContext) {
        let calendar = Calendar(entity: calendar, insertInto: context)
        do {
            try context.save()
            CoreDataManager.shared.calendar = calendar
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func setupYears(years: NSEntityDescription, context: NSManagedObjectContext) {
        let currentYear = DateManager.getYear(date: Date())
        let startDate = currentYear - 50
        for yearNumber in 0..<100 {
            let year = Year(entity: years, insertInto: context)
            year.setValue(startDate + yearNumber, forKeyPath: "number")
            do {
                try context.save()
                CoreDataManager.shared.calendar!.addToYears(year)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    private func setupMonths(months: NSEntityDescription, days: NSEntityDescription, context: NSManagedObjectContext) {
        guard let years = CoreDataManager.shared.calendar!.years.allObjects as? [Year] else {return}
        for year in years {
            for monthNumber in 0..<12 {
                var monthName: MonthString?
                monthName = DateManager.getMonthName(monthNumber: monthNumber)
                let month = Month(entity: months, insertInto: context)
                month.name = monthName!.rawValue
                month.monthNumber = Int64(monthNumber + 1)
                setupDays(year: year, month: month, monthNumber: monthNumber + 1, daysDescription: days, context: context)
                do {
                    try context.save()
                    year.addToMonths(month)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    private func setupDays(year: Year, month: Month, monthNumber: Int, daysDescription: NSEntityDescription, context: NSManagedObjectContext) {
        var dateComponents = DateComponents()
        dateComponents.year = Int(year.number)
        dateComponents.month = monthNumber
        guard let date = Foundation.Calendar.current.date(from: dateComponents), let numberOfDaysInMonth = Foundation.Calendar.current.range(of: .day, in: .month, for: date)?.count else {
            return
        }
        for number in 0..<numberOfDaysInMonth {
            let day = Day(entity: daysDescription, insertInto: context)
            day.dateNumber = Int64(number)
            month.addToDays(day)
        }
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        }
        return appDelegate.persistentContainer.viewContext
    }
    
}
