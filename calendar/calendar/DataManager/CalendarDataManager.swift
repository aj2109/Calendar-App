//
//  CalendarDataManager.swift
//  calendar
//
//  Created by Adam Jessop on 11/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import Foundation

class CalendarDataManager {
    
    static var shared = CalendarDataManager()
    let monthsDataSource = MonthsDataSource()
    let monthsDelegate = MonthsDelegate()
    let activeDayDelegateDataSource = ActiveDayDelegateDataSource()
    let activeMonthDataSource = ActiveMonthDataSource()
    let activeMonthDelegate = ActiveMonthDelegate()
    var currentYear: Year!
    var currentMonth: Month!
    var currentDay: Day?
    var selectedDayIndex: Int?
}
