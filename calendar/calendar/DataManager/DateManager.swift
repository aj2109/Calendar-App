//
//  DataManager.swift
//  calendar
//
//  Created by Adam Jessop on 07/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

struct DateManager {
        
    static func workoutDaysInaMonth(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Foundation.Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)
        return range!.count
    }
    
    static func getCurrentYear() -> Int {
        let calendar = Foundation.Calendar.current
        return calendar.component(.year, from: Date())
    }
    
//    static func getCurrentYear() -> Year {
//        let date = Date()
//        CoreDataManager.shared.calendar
//    }
    
}
