//
//  DataManager.swift
//  calendar
//
//  Created by Adam Jessop on 07/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit
import EventKit

struct DateManager {
    
    static var todaysDate = Date()
    
    static var eventStore = EKEventStore()
    
    static func addToEKEventStore(event: Event, completion: @escaping () -> ()) {
        eventStore.requestAccess(to: .event) { (access, error) in
            if let error = error {
                print("Calendar saving FAILED: \(error)!")
            } else if access {
                let ekEvent = EKEvent(eventStore: eventStore)
                ekEvent.startDate = event.fromDate
                ekEvent.endDate = event.toDate
                ekEvent.title = event.title
                ekEvent.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(ekEvent, span: .thisEvent)
                    completion()
                } catch let error as NSError {
                    completion()
                    print("Calendar saving FAILED on do try: \(error)")
                }
                print("successfully saved event in calendar :D!")
            } else {
                completion()
                print("Calendar saving FAILED: access = false!")
            }
        }
    }
    
    static func getDateFromDay(day: Day) -> Date? {
        let month = day.month
        let year = month.year
        var dateComponents = DateComponents()
        dateComponents.year = Int(year.number)
        dateComponents.month = Int(month.monthNumber)
        dateComponents.day = Int(day.dateNumber)
        if let date = Foundation.Calendar.current.date(from: dateComponents) {
            return date
        } else {
            return nil
        }
    }
    
    static func addTimeToDate(date: Date, additionalDateComponents: DateComponents) -> Date? {
        var dateComponents = Foundation.Calendar.current.dateComponents([.year,.month,.day], from: date)
        if let hour = additionalDateComponents.hour, let minute = additionalDateComponents.minute {
            dateComponents.hour = hour
            dateComponents.minute = minute
            return Foundation.Calendar.current.date(from: dateComponents)
        } else {
            return nil
        }
    }
    
    static func createFullDateFromCurrentDay(dateComponents: DateComponents) -> Date? {
        if let currentDay = CalendarDataManager.shared.currentDay, let date = getDateFromDay(day: currentDay) {
            return addTimeToDate(date: date, additionalDateComponents: dateComponents)
        } else {
            return nil
        }
    }
    
    static func workoutDaysInaMonth(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Foundation.Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)
        return range!.count
    }
    
    static func changeCurrentDate(newMonth: Int, newYear: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = newYear
        dateComponents.month = newMonth
        todaysDate = Foundation.Calendar.current.date(from: dateComponents)!
    }
    
    static func getYear(previous: Bool = false, next: Bool = false, date: Date) -> Int {
        if previous {
            return Foundation.Calendar.current.component(.year, from: date) - 1
        } else if next {
            return Foundation.Calendar.current.component(.year, from: date) + 1
        } else {
            return Foundation.Calendar.current.component(.year, from: date)
        }
    }
    
    static func getMonth(previous: Bool = false, next: Bool = false, date: Date) -> Int  {
        if previous {
            return Foundation.Calendar.current.component(.month, from: date) - 1
        } else if next {
            return Foundation.Calendar.current.component(.month, from: date) + 1
        } else {
            return Foundation.Calendar.current.component(.month, from: date)
        }
    }
    
    static func getMonthName(monthNumber: Int) -> MonthString? {
        switch monthNumber {
        case 0: return MonthString.January
        case 1: return MonthString.February
        case 2: return MonthString.March
        case 3: return MonthString.April
        case 4: return MonthString.May
        case 5: return MonthString.June
        case 6: return MonthString.July
        case 7: return MonthString.August
        case 8: return MonthString.September
        case 9: return MonthString.October
        case 10: return MonthString.November
        case 11: return MonthString.December
        default:
            return MonthString(rawValue: "UHOH")
        }
    }
    
    static func getCurrentYearAndMonthObject() -> (Year, Month) {
        let currentYear = getYear(date: Date())
        let currentMonth = getMonth(date: Date())
        let currentMonthName = getMonthName(monthNumber: currentMonth - 1)!
        let years = CoreDataManager.shared.calendar!.years.allObjects as! [Year]
        let currentYearObject = years.filter({Int($0.number) == currentYear}).first!
        let months = currentYearObject.months.allObjects as! [Month]
        let currentMonthObject = months.filter({$0.name == currentMonthName.rawValue}).first!
        return (currentYearObject, currentMonthObject)
    }
    
    static func getPreviousYearAndMonthObject(currentYear: Year, currentMonth: Month) -> (Year, Month) {
        var year = currentYear
        var month = currentMonth
        if currentMonth.monthNumber == 1 {
            let previousYear = getYear(previous: true, next: false, date: Foundation.Calendar.current.date(byAdding: .year, value: 0, to: todaysDate)!)
            let years = CoreDataManager.shared.calendar!.years.allObjects as! [Year]
            year = years.filter({Int($0.number) == previousYear}).first!
            let december = 12
            let decemberMonthName = getMonthName(monthNumber: december - 1)!
            let months = year.months.allObjects as! [Month]
            month = months.filter({$0.name == decemberMonthName.rawValue}).first!
        } else {
            let previousMonth = getMonth(previous: true, next: false, date: todaysDate)
            let previousMonthName = getMonthName(monthNumber: previousMonth - 1)!
            let months = year.months.allObjects as! [Month]
            month = months.filter({$0.name == previousMonthName.rawValue}).first!
        }
        changeCurrentDate(newMonth: Int(month.monthNumber), newYear: Int(year.number))
        return (year, month)
    }
    
    static func getNextYearAndMonthObject(currentYear: Year, currentMonth: Month) -> (Year, Month) {
        var year = currentYear
        var month = currentMonth
        if currentMonth.monthNumber == 12 {
            let nextYear = getYear(previous: false, next: true, date: todaysDate)
            let years = CoreDataManager.shared.calendar!.years.allObjects as! [Year]
            year = years.filter({Int($0.number) == nextYear}).first!
            let january = 1
            let januaryMonthName = getMonthName(monthNumber: january - 1)!
            let months = year.months.allObjects as! [Month]
            month = months.filter({$0.name == januaryMonthName.rawValue}).first!
        } else {
            let nextMonth = getMonth(previous: false, next: true, date: todaysDate)
            let nextMonthName = getMonthName(monthNumber: nextMonth - 1)!
            let months = year.months.allObjects as! [Month]
            month = months.filter({$0.name == nextMonthName.rawValue}).first!
        }
        changeCurrentDate(newMonth: Int(month.monthNumber), newYear: Int(year.number))
        return (year, month)
    }
    
    static func checkIfToday(day: Day) -> Bool {
        if
            day.dateNumber == Foundation.Calendar.current.component(.day, from: Date()),
            day.month.monthNumber == Foundation.Calendar.current.component(.month, from: Date()),
            day.month.year.number == Foundation.Calendar.current.component(.year, from: Date()) {
            return true
        } else {
            return false
        }
    }
    
    static func checkIfThisMonth(month: Month) -> Bool {
        if
            month.monthNumber == Foundation.Calendar.current.component(.month, from: Date()),
            month.year.number == Foundation.Calendar.current.component(.year, from: Date()) {
            return true
        } else {
            return false
        }
    }
    
    static func checkIfThisYear(year: Year) -> Bool {
        if year.number == Foundation.Calendar.current.component(.year, from: Date()) {
            return true
        } else {
            return false
        }
    }
    
    static func getSortedListOfDays(days: [Any]) -> [Day]? {
        if let days = days as? [Day] {
            return days.sorted(by: { (dayOne, dayTwo) -> Bool in
                return dayOne.dateNumber < dayTwo.dateNumber
            })
        } else {
            return nil
        }
    }
    
    static func getSortedListOfMonths(months: [Any]) -> [Month]? {
        if let months = months as? [Month] {
            return months.sorted(by: { (monthOne, monthTwo) -> Bool in
                return monthOne.monthNumber < monthTwo.monthNumber
            })
        } else {
            return nil
        }
    }
    
    static func getSortedListOfYears(years: [Any]) -> [Year]? {
        if let years = years as? [Year] {
            return years.sorted(by: { (yearOne, yearTwo) -> Bool in
                return yearOne.number < yearTwo.number
            })
        } else {
            return nil
        }
    }
    
    static func getListOfAllMonths() -> [Month] {
        var months = [Month]()
        guard
            let allYears = CoreDataManager.shared.calendar?.years.allObjects as? [Year],
            let sortedYears = DateManager.getSortedListOfYears(years: allYears) else {return []}
            sortedYears.forEach { (year) in
                if let monthList = year.months.allObjects as? [Month], let sortedMonthList = DateManager.getSortedListOfMonths(months: monthList) {
                for month in sortedMonthList {
                    months.append(month)
                }
            }
        }
        return months
    }
    
}
