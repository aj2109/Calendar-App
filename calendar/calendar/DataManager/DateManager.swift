//
//  DataManager.swift
//  calendar
//
//  Created by Adam Jessop on 07/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

struct DateManager {
    
    static var currentDate = Date()
    
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
        currentDate = Foundation.Calendar.current.date(from: dateComponents)!
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
            let previousYear = getYear(previous: true, next: false, date: Foundation.Calendar.current.date(byAdding: .year, value: 0, to: currentDate)!)
            let years = CoreDataManager.shared.calendar!.years.allObjects as! [Year]
            year = years.filter({Int($0.number) == previousYear}).first!
            let december = 12
            let decemberMonthName = getMonthName(monthNumber: december - 1)!
            let months = year.months.allObjects as! [Month]
            month = months.filter({$0.name == decemberMonthName.rawValue}).first!
        } else {
            let previousMonth = getMonth(previous: true, next: false, date: currentDate)
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
            let nextYear = getYear(previous: false, next: true, date: currentDate)
            let years = CoreDataManager.shared.calendar!.years.allObjects as! [Year]
            year = years.filter({Int($0.number) == nextYear}).first!
            let january = 1
            let januaryMonthName = getMonthName(monthNumber: january - 1)!
            let months = year.months.allObjects as! [Month]
            month = months.filter({$0.name == januaryMonthName.rawValue}).first!
        } else {
            let nextMonth = getMonth(previous: false, next: true, date: currentDate)
            let nextMonthName = getMonthName(monthNumber: nextMonth - 1)!
            let months = year.months.allObjects as! [Month]
            month = months.filter({$0.name == nextMonthName.rawValue}).first!
        }
        changeCurrentDate(newMonth: Int(month.monthNumber), newYear: Int(year.number))
        return (year, month)
    }
    
}
