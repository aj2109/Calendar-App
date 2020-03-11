//
//  ActiveMonthDataSource.swift
//  calendar
//
//  Created by Adam Jessop on 11/03/2020.
//  Copyright © 2020 Jessops. All rights reserved.
//

import UIKit

class ActiveMonthDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CalendarDataManager.shared.currentMonth.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CalendarCell {
            if let index = CalendarDataManager.shared.selectedDayIndex, indexPath.row == index {
                cell.backgroundColor = .purple
            }
            cell.dateLabel.text = "\(indexPath.row + 1)"
            if let sortedDays = DateManager.getSortedListOfDays(days: CalendarDataManager.shared.currentMonth.days.allObjects) {
                let day = sortedDays[indexPath.row]
                cell.day = day
                if DateManager.checkIfToday(day: day) {
                    CoreDataManager.shared.today = day
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
